#!/usr/bin/env python

import requests
import os
import argparse
import json

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

class CloudCenter(object):
    def __init__(self, hostname, username, password, verify_certs=True, port='443'):
        self.session = requests.Session()
        self.session.verify = verify_certs

        self.base_url = f'https://{hostname}:{port}'
        self.username = username
        self.password = password
        self.session.auth = (username,password)

    def api_call(self, method, query, json=None, data=None, content_type=None):
        """
        Make the CloudCenter API call. Returns (ok, json)
        """
        headers={
            'Accept': 'application/json',
        }
        if content_type:
            headers = {'Content-Type': content_type}
        
        response = self.session.request(method, self.base_url + query, json=json, data=data, headers=headers)
        
        if response.status_code >= 200 and response.status_code < 300:
            try:
                return True, response.json()
            except:
                return True, None
        else:
            print("API call returned error: %s" % response.content)
            try:
                return False, response.json()
            except:
                return False, None
                
        # Should never make it here
        return False, None

    def get_environments(self):
        ok, env_json = self.api_call('GET', '/v1/environments')
        if not ok:
            print("An error occurred while retrieving environments")
            return None

        return env_json['deploymentEnvironments']

    def get_environment_by_name(self, name):
        environments = self.get_environments()
        if environments is None:
            return None
        
        for env in environments:
            if env['name'] == name:
                return env
        
        return None
    
    def get_applications(self):
        ok, app_json = self.api_call('GET', '/v1/apps')
        if not ok:
            print("An error occurred while retrieving applications")
            return None
        
        return app_json['apps']

    def get_application_details(self, id):
        ok, app_json = self.api_call('GET', f'/v1/apps/{id}')
        if not ok:
            print("An error occurred while retrieving application details")
            return None
        
        return app_json

    def get_application_by_name(self, name):
        apps = self.get_applications()
        if apps is None:
            return None

        for app in apps:
            if app['name'] == name:
                return self.get_application_details(app['id'])

        return None

    def get_deployments(self):
        ok, deps_json = self.api_call('GET', '/v2/jobs')
        if not ok:
            print("An error occurred while retrieving deployments")
            return None
        
        return deps_json['jobs']

    def get_deployment_details(self, id):
        ok, dep_json = self.api_call('GET', f'/v1/jobs/{id}')
        if not ok:
            print("An error occurred while retrieving deployment details")
            return None
        
        return dep_json

    def get_deployment_by_name(self, name):
        deps = self.get_deployments()
        if deps is None:
            return None
        
        for dep in deps:
            if dep['name'] == name:
                return self.get_deployment_details(dep['id'])

        return None

    def delete_deployment_by_name(self, name):
        dep = self.get_deployment_by_name(name)
        if dep is None:
            return None
        
        ok, res_json = self.api_call('DELETE', f'/v2/jobs/{dep["id"]}')
        if not ok:
            print("An error occurred while deleting the deployment")
            return None
        
        return res_json

    def deployment_start(self, deployment_name, application_name, environment_name, instance_size=None, application_params=[], tag_names=[]):
        app = self.get_application_by_name(application_name)
        env = self.get_environment_by_name(environment_name)

        if app is None or env is None:
            print("An error occurred while getting app and environment details")
            return None
        
        deployment_json = {
            "appId": app['id'],
            "appVersion": app['version'],
            "name": deployment_name,
            "metadatas": [
                    {
                            "namespace": "",
                            "name": "Name",
                            "value": "%JOB_NAME%",
                            "editable": False,
                            "required": True
                    }
            ],
            "environmentId": env['id'],
            "tagIds": [],
            "securityProfileIds": [],
            "agingPolicyId": None,
            "suspensionPolicyId": None,
            "policyIds": None,
            "preventTermination": False,
            "parameters": {
                    "appParams": []
            },
            "jobs": [],
        }

        # Apply application parameters
        for param in application_params:
            deployment_json['parameters']['appParams'].append({
                'name': param[0],
                'value': param[1]
            })

        # Apply service tiers
        for tier in app['serviceTiers']:
            deployment_json['jobs'].append({
                "tierId": tier['id'],
                "policyIds": None,
                "tagIds": [],
                "securityProfileIds": [],
                "parameters": {
                        "appParams": [
                        ],
                        "envParams": [],
                        "cloudParams": {
                                "instance": instance_size
                        }
                }
            })

        # Apply system tags
        for tag_name in tag_names:
            tag = self.get_system_tag_by_name(tag_name)
            if tag is not None:
                deployment_json['tagIds'].append(tag['id'])
            else:
                print(f'Warning - system tag "{tag_name}" not found, ignoring')

        ok, res_json = self.api_call('POST', '/v2/jobs', json=deployment_json)
        if not ok:
            print("An error occurred while starting the deployment")
            return None

        return res_json

    def get_system_tags(self):
        ok, tags_json = self.api_call('GET', '/v1/systemTags')
        if not ok:
            print("An error occurred while retrieving tags")
            return None
        
        return tags_json['systemTags']

    def get_system_tag_by_name(self, name):
        tags = self.get_system_tags()
        if tags is None:
            return None
        
        for tag in tags:
            if tag['name'] == name:
                return tag
        
        return None


def main():
    parser = argparse.ArgumentParser(description="Interact with Cisco CloudCenter via API")
    parser.add_argument('--username', required=True)
    parser.add_argument('--password', required=True)
    parser.add_argument('--hostname', required=True)

    subparsers = parser.add_subparsers(dest='cmd')

    # Environment commands
    env_parser = subparsers.add_parser('environment', help='Deployment environments')
    env_subparsers = env_parser.add_subparsers(dest='subcmd')

    env_list_parser = env_subparsers.add_parser('list', help="List deployment environments")
    env_find_parser = env_subparsers.add_parser('find', help="Find deployment environment")
    env_find_parser.add_argument('--name', required=True)

    # Application commands
    app_parser = subparsers.add_parser('application', help='Applications')
    app_subparsers = app_parser.add_subparsers(dest='subcmd')

    app_list_parser = app_subparsers.add_parser('list', help="List applications")
    app_find_parser = app_subparsers.add_parser('find', help="Find application")
    app_find_parser.add_argument('--name', required=True)

    # Deployment commands
    dep_parser = subparsers.add_parser('deployment', help='Deployments')
    dep_subparsers = dep_parser.add_subparsers(dest='subcmd')

    dep_start_parser = dep_subparsers.add_parser('start', help='Start deployments')
    dep_start_parser.add_argument('--name', required=True, help='Name of the deployment to be created')
    dep_start_parser.add_argument('--application', required=True, help='Name of tha application profile')
    dep_start_parser.add_argument('--environment', required=True, help='Name of the environment to deploy into')
    dep_start_parser.add_argument('--param', action='append', help='Application parameters in the form "PARAM=VALUE"')
    dep_start_parser.add_argument('--instancesize', help='Instance size to use for all application tiers')

    dep_list_parser = dep_subparsers.add_parser('list', help='List deployments')
    dep_find_parser = dep_subparsers.add_parser('find', help='Find deployments')
    dep_find_parser.add_argument('--name', required=True)
    dep_stop_parser = dep_subparsers.add_parser('stop', help='Stop deployments')
    dep_stop_parser.add_argument('--name', required=True)

    # Tag commands
    tag_parser = subparsers.add_parser('tag', help='Tags')
    tag_subparsers = tag_parser.add_subparsers(dest='subcmd')

    tag_list_parser = tag_subparsers.add_parser('list', help='List tags')
    tag_find_parser = tag_subparsers.add_parser('find', help='Find tag')
    tag_find_parser.add_argument('--name', required=True)

    args = parser.parse_args()

    username = args.username
    password = args.password
    hostname = args.hostname

    ccc = CloudCenter(hostname, username, password, False)

    if args.cmd == 'environment':
        if args.subcmd == 'find':
            print(ccc.get_environment_by_name(args.name))
        if args.subcmd == 'list':
            envs = ccc.get_environments()
            if envs is not None:
                for env in envs:
                    print(env['name'])
    elif args.cmd == 'application':
        if args.subcmd == 'list':
            apps = ccc.get_applications()
            if apps is not None:
                for app in apps:
                    print(app['name'])
        if args.subcmd == 'find':
            print(ccc.get_application_by_name(args.name))
    elif args.cmd == 'deployment':
        if args.subcmd == 'start':
            print(args)
            params=[]
            if args.param is not None:
                for param in args.param:
                    k,v = param.split('=')
                    params.append((k,v))
            
            print(ccc.deployment_start(args.name, args.application, args.environment, application_params=params, instance_size=args.instancesize))
        if args.subcmd == 'list':
            deps = ccc.get_deployments()
            if deps is not None:
                for dep in deps:
                    print(dep['name'])
        if args.subcmd == 'find':
            print(ccc.get_deployment_by_name(args.name))
        if args.subcmd == 'stop':
            print(ccc.delete_deployment_by_name(args.name))
    elif args.cmd == 'tag':
        if args.subcmd == 'list':
            tags = ccc.get_system_tags()
            if tags is not None:
                for tag in tags:
                    print(tag['name'])
        if args.subcmd == 'find':
            print(ccc.get_system_tag_by_name(args.name))
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
#!/usr/bin/env python3

import cloudcenter
import os
import time
import requests
import re

# gather required parameters - no error checking, might as well crash if we don't have these
CCC_USERNAME = os.environ['CCC_USERNAME']
CCC_KEY = os.environ['CCC_KEY']
CCC_HOSTNAME = os.environ['CCC_HOSTNAME']
BUILD_TAG = os.environ['BUILD_TAG']
CCC_APPLICATION_NAME = os.environ['CCC_APPLICATION_NAME']
CCC_ENVIRONMENT_NAME = os.environ['CCC_ENVIRONMENT_NAME']

GIT_BRANCH = os.environ['GIT_BRANCH'] # in Jenkins, this will most likely be of the form origin/master
BRANCH_NAME = os.path.basename(GIT_BRANCH) # we just want 'master'

TIMEOUT = 10*60 # 10mins (in seconds)

print(f'Using CCC_HOSTNAME {CCC_HOSTNAME}, CCC_USERNAME {CCC_USERNAME}, CCC_KEY {CCC_KEY}')
print(f'Using Git branch {BRANCH_NAME}')

deployment_name_prefix='wp-prod'
dep_name = f'{deployment_name_prefix}-{BUILD_TAG}'

ccc = cloudcenter.CloudCenter(CCC_HOSTNAME, CCC_USERNAME, CCC_KEY, verify_certs=False)

## Find job IDs of any existing production deployments
existing_dep_names = []
existing_jobs = ccc.get_deployments()
if existing_jobs is not None:
    for job in existing_jobs:
        if re.match(r'^%s'%deployment_name_prefix, job['name']):
            existing_dep_names.append(job['name'])

print(f"Found existing production deployments with names: {existing_dep_names}")


print('\n\nStarting new production deployment in CloudCenter')

start_time = time.time()
test_job = ccc.deployment_start(dep_name, CCC_APPLICATION_NAME, CCC_ENVIRONMENT_NAME, tag_names=["wp_production"], application_params=[
    ('BRANCH', BRANCH_NAME),
    ('APPD_CONF_CONTROLLER_HOST', os.environ['APPD_CONF_CONTROLLER_HOST']),
    ('APPD_CONF_CONTROLLER_PORT', os.environ['APPD_CONF_CONTROLLER_PORT']),
    ('APPD_INSTALLER_URL', os.environ['APPD_INSTALLER_URL']),
    ('APPD_CONF_ACCESS_KEY', os.environ['APPD_CONF_ACCESS_KEY']),

])

if test_job is None:
    print("An error occurred starting deployment")
    exit(1)

print(f'Deployment is now starting with id {test_job["id"]}')

while (time.time() - start_time) < TIMEOUT:
    deployment = ccc.get_deployment_by_name(dep_name)
    if deployment is None:
        print("An error occurred getting the deploymet details")
        exit(1)
    
    if deployment['status'] == 'JobError':
        print("The deployment failed to start correctly")
        print(f' -> {deployment["jobStatusMessage"]}\n\n')
        print('Attempting to terminate failed deployment ...')
        ccc.delete_deployment_by_name(dep_name)
        exit(1)
    
    if 'accessLink' not in deployment or deployment['accessLink'] is None or deployment['accessLink'] == '':
        print("Sleeping longer as job isn't deployed yet")
        time.sleep(25)
    else:
        print(f"Got accessLink {deployment['accessLink']}")
        try:
            res = requests.get(deployment['accessLink'])
        except:
            res=None
        if res is not None and res.ok:
            if re.search(r'My awesome website', res.text):
                print("Correct content received - new production deployment ready")

                print("Terminating old production deployment(s)")
                for old_dep_name in existing_dep_names:
                    ccc.delete_deployment_by_name(old_dep_name)

                exit(0)


    time.sleep(5)

print("Timed out waiting for deployment to start")

print("Terminating deployment")
ccc.delete_deployment_by_name(dep_name)

exit(1)
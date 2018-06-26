#!/usr/bin/env python

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

dep_name = f'test-{BUILD_TAG}'

ccc = cloudcenter.CloudCenter(CCC_HOSTNAME, CCC_USERNAME, CCC_KEY, verify_certs=False)

print('\n\nStarting deployment in CloudCenter')

start_time = time.time()
test_job = ccc.deployment_start(dep_name, CCC_APPLICATION_NAME, CCC_ENVIRONMENT_NAME, tag_names=["wp_development"], application_params=[
    ('BRANCH', BRANCH_NAME),

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
                print("Correct content received")

                print("Terminating deployment")
                ccc.delete_deployment_by_name(dep_name)

                exit(0)


    time.sleep(5)

print("Timed out waiting for deployment to start")

print("Terminating deployment")
ccc.delete_deployment_by_name(dep_name)

exit(1)
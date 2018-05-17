#!/bin/sh

set +e

echo "Executing prod-deploy.sh in ccc-wordpress"
echo "Using CCC_URL $CCC_URL, CCC_USERNAME $CCC_USERNAME and CCC_KEY $CCC_KEY"

BRANCH_NAME=$(basename $GIT_BRANCH)

echo "Using Git branch: ${BRANCH_NAME}"

cat > /tmp/json << EOM
{
        "appId": "31",
        "appVersion": "2",
        "name": "prod-${BUILD_TAG}",
        "metadatas": [
                {
                        "namespace": "",
                        "name": "Name",
                        "value": "%JOB_NAME%",
                        "editable": false,
                        "required": true
                }
        ],
        "environmentId": "1",
        "tagIds": [],
        "securityProfileIds": [],
        "agingPolicyId": null,
        "suspensionPolicyId": null,
        "policyIds": null,
        "preventTermination": false,
        "parameters": {
                "appParams": [
                        {
                                "name": "DB_NAME",
                                "value": "wordpress"
                        },
                        {
                                "name": "DB_USER",
                                "value": "root"
                        },
                        {
                                "name": "DB_PASSWORD",
                                "value": "welcome2cliqr"
                        },
                        {
                                "name": "APPD_CONF_CONTROLLER_HOST",
                                "value": "10.152.0.8"
                        },
                        {
                                "name": "APPD_CONF_CONTROLLER_PORT",
                                "value": "8090"
                        },
                        {
                                "name": "APPD_CONF_APP",
                                "value": "MyAwesomeWebsite"
                        },
                        {
                                "name": "APPD_CONF_ACCOUNT_NAME",
                                "value": "customer1"
                        },
                        {
                                "name": "APPD_CONF_ACCESS_KEY",
                                "value": "d939e547-0a93-468d-9107-f1044becad38"
                        },
                        {
                                "name": "GIT_TAG",
                                "value": "${BRANCH_NAME}"
                        }
                ],
                "cloudParams": {
                        "cloudRegionId": "1",
                        "accountId": "1"
                }
        },
        "jobs": [
                {
                        "tierId": "32",
                        "policyIds": [
                                 "1"
                         ],
                        "tagIds": [],
                        "securityProfileIds": [],
                        "parameters": {
                                "appParams": [
                                        {
                                                "name": "referredJob",
                                                "value": ""
                                        },
                                        {
                                                "name": "SSHPreference",
                                                "value": "NO_PREFERENCE"
                                        }
                                ],
                                "envParams": [],
                                "cloudParams": {
                                        "cloudRegionId": "1",
                                        "accountId": "1",
                                        "volumes": [
                                                {
                                                        "name": "RootVolume",
                                                        "bootable": true,
                                                        "size": 0,
                                                        "type": "pd-standard",
                                                        "iops": null
                                                }
                                        ],
                                        "rootVolumeSize": "0",
                                        "cloudProperties": [
                                                {
                                                        "name": "LaunchZone",
                                                        "value": "australia-southeast1-c"
                                                },
                                                {
                                                        "name": "projectName",
                                                        "value": "ccc-managed"
                                                }
                                        ],
                                        "nics": [
                                                {
                                                        "order": 1,
                                                        "netId": "ccc-managed:ccc-net",
                                                        "id": "ccc-subnet",
                                                        "allocatePublicIp": "true"
                                                }
                                        ],
                                        "instance": "g1-small"
                                }
                        },
                        "numNodesToLaunch": 1
                },
                {
                        "tierId": "33",
                        "policyIds": null,
                        "tagIds": [],
                        "securityProfileIds": [],
                        "parameters": {
                                "appParams": [
                                        {
                                                "name": "referredJob",
                                                "value": ""
                                        },
                                        {
                                                "name": "SSHPreference",
                                                "value": "NO_PREFERENCE"
                                        }
                                ],
                                "envParams": [],
                                "cloudParams": {
                                        "cloudRegionId": "1",
                                        "accountId": "1",
                                        "volumes": [
                                                {
                                                        "name": "RootVolume",
                                                        "bootable": true,
                                                        "size": 0,
                                                        "type": "pd-standard",
                                                        "iops": null
                                                }
                                        ],
                                        "rootVolumeSize": "0",
                                        "cloudProperties": [
                                                {
                                                        "name": "LaunchZone",
                                                        "value": "australia-southeast1-c"
                                                },
                                                {
                                                        "name": "projectName",
                                                        "value": "ccc-managed"
                                                }
                                        ],
                                        "nics": [
                                                {
                                                        "order": 1,
                                                        "netId": "ccc-managed:ccc-net",
                                                        "id": "ccc-subnet",
                                                        "allocatePublicIp": "true"
                                                }
                                        ],
                                        "instance": "g1-small"
                                }
                        }
                },
                {
                        "tierId": "34",
                        "policyIds": null,
                        "tagIds": [],
                        "securityProfileIds": [],
                        "parameters": {
                                "appParams": [
                                        {
                                                "name": "referredJob",
                                                "value": ""
                                        },
                                        {
                                                "name": "SSHPreference",
                                                "value": "NO_PREFERENCE"
                                        }
                                ],
                                "envParams": [],
                                "cloudParams": {
                                        "cloudRegionId": "1",
                                        "accountId": "1",
                                        "volumes": [
                                                {
                                                        "name": "RootVolume",
                                                        "bootable": true,
                                                        "size": 0,
                                                        "type": "pd-standard",
                                                        "iops": null
                                                }
                                        ],
                                        "rootVolumeSize": "0",
                                        "cloudProperties": [
                                                {
                                                        "name": "LaunchZone",
                                                        "value": "australia-southeast1-c"
                                                },
                                                {
                                                        "name": "projectName",
                                                        "value": "ccc-managed"
                                                }
                                        ],
                                        "nics": [
                                                {
                                                        "order": 1,
                                                        "netId": "ccc-managed:ccc-net",
                                                        "id": "ccc-subnet",
                                                        "allocatePublicIp": "true"
                                                }
                                        ],
                                        "instance": "g1-small"
                                }
                        }
                }
        ],
        "timeZone": "UTC"
}


EOM

# Find job ID of any existing prod deployments
EXISTING_DEPLOYMENTS=$(curl -s -g -k -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' -u ${CCC_USERNAME}:${CCC_KEY} "${CCC_URL}/v2/jobs?search=[deploymentEntity.name,el,prod]" |jq -r '.jobs[].id')
echo "Found existing production deployment job IDs: ${EXISTING_DEPLOYMENTS}"

RESULT=0

echo "Creating new production job in CloudCenter"
CREATE_RESULT=`curl -s -k -X POST -H "Accept: application/json" -H "Content-Type: application/json" -u ${CCC_USERNAME}:${CCC_KEY} -d @/tmp/json "${CCC_URL}/v2/jobs"` 

# echo "Result of submit job API call: '${CREATE_RESULT}'"
JOB_ID="`echo $CREATE_RESULT | jq -r .id`"
echo "Got job ID ${JOB_ID}"

COUNT=0
STOP=0
until [ $STOP -ne 0 ]
do
  echo -e "\nwaiting for HTTP to come up ..."
  sleep 5
  
  ACCESS_LINK=`curl -s -k -X GET -H "Accept: application/json" -H "Content-Type: application/json" -u ${CCC_USERNAME}:${CCC_KEY}  "${CCC_URL}/v1/jobs/${JOB_ID}"|jq -r .accessLink`
  echo "Got access link ${ACCESS_LINK}"
  
  CONTENT=`curl -s -L ${ACCESS_LINK}`
  if [ $? -eq 0 ]
  then
    echo -e "\n\nHTTP connection successful"
    echo "Retrieved content from server: `echo $CONTENT|head` ..."
    
    
    echo $CONTENT | grep "My awesome website" >/dev/null
    if [ $? -eq 0 ]
    then
      echo "Correct content received - new production job is ready!"
      STOP=1
      RESULT=0
    fi
  else
    # Sleep an extra 30 seconds since the servers haven't even started yet
    sleep 30
  fi
  
  
  let COUNT=COUNT+1
  if [ $COUNT -gt 150 ]
  then 
    echo "Timed out waiting for HTTP to come up"
    STOP=1
    RESULT=1
  fi
done

echo "Stopping old production job(s) ..."
for OLD_JOB_ID in $EXISTING_DEPLOYMENTS
do
  curl -s -k -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" -u ${CCC_USERNAME}:${CCC_KEY}  "${CCC_URL}/v2/jobs/${OLD_JOB_ID}"
done

echo "Exiting with result $RESULT"
exit $RESULT


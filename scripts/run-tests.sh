#!/bin/sh

set +e
set +x

echo "Executing run-tests.sh in ccc-wordpress"
echo "Using CCC_URL $CCC_URL, CCC_USERNAME $CCC_USERNAME and CCC_KEY $CCC_KEY"

BRANCH_NAME=$(basename $GIT_BRANCH)

echo "Using Git branch: ${BRANCH_NAME}"

cat > /tmp/json << EOM
{
        "appId": "94",
        "appVersion": "2",
        "name": "test-${BUILD_TAG}",
        "metadatas": [
                {
                        "namespace": "",
                        "name": "Name",
                        "value": "%JOB_NAME%",
                        "editable": false,
                        "required": true
                }
        ],
        "environmentId": "2",
        "tagIds": [
                3
        ],
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
                                "value": "35.227.250.16"
                        },
                        {
                                "name": "APPD_CONF_CONTROLLER_PORT",
                                "value": "80"
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
                                "value": "31086ce7-8846-4daa-b744-2cad69b078b0"
                        },
                        {
                                "name": "GIT_TAG",
                                "value": "${BRANCH_NAME}"
                        }
                ],
                "cloudParams": {
                        "cloudRegionId": "3",
                        "accountId": "3"
                }
        },
        "jobs": [
                {
                        "tierId": "95",
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
                                        "cloudRegionId": "3",
                                        "accountId": "3",
                                        "volumes": [
                                                {
                                                        "name": "RootVolume",
                                                        "bootable": true,
                                                        "size": 0,
                                                        "type": null,
                                                        "iops": null
                                                }
                                        ],
                                        "rootVolumeSize": "0",
                                        "cloudProperties": [
                                                {
                                                        "name": "LaunchZone",
                                                        "value": "australia-southeast1-b"
                                                },
                                                {
                                                        "name": "projectName",
                                                        "value": "cloudcenter-188704"
                                                }
                                        ],
                                        "nics": [
                                                {
                                                        "order": 1,
                                                        "netId": "cloudcenter-188704:cloudcenter",
                                                        "id": "cloudcenter",
                                                        "allocatePublicIp": "false"
                                                }
                                        ],
                                        "instance": "g1-small"
                                }
                        },
                        "numNodesToLaunch": 1
                },
                {
                        "tierId": "96",
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
                                        "cloudRegionId": "3",
                                        "accountId": "3",
                                        "volumes": [
                                                {
                                                        "name": "RootVolume",
                                                        "bootable": true,
                                                        "size": 0,
                                                        "type": null,
                                                        "iops": null
                                                }
                                        ],
                                        "rootVolumeSize": "0",
                                        "cloudProperties": [
                                                {
                                                        "name": "LaunchZone",
                                                        "value": "australia-southeast1-b"
                                                },
                                                {
                                                        "name": "projectName",
                                                        "value": "cloudcenter-188704"
                                                }
                                        ],
                                        "nics": [
                                                {
                                                        "order": 1,
                                                        "netId": "cloudcenter-188704:cloudcenter",
                                                        "id": "cloudcenter",
                                                        "allocatePublicIp": "false"
                                                }
                                        ],
                                        "instance": "g1-small"
                                }
                        }
                },
                {
                        "tierId": "97",
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
                                        "cloudRegionId": "3",
                                        "accountId": "3",
                                        "volumes": [
                                                {
                                                        "name": "RootVolume",
                                                        "bootable": true,
                                                        "size": 0,
                                                        "type": null,
                                                        "iops": null
                                                }
                                        ],
                                        "rootVolumeSize": "0",
                                        "cloudProperties": [
                                                {
                                                        "name": "LaunchZone",
                                                        "value": "australia-southeast1-b"
                                                },
                                                {
                                                        "name": "projectName",
                                                        "value": "cloudcenter-188704"
                                                }
                                        ],
                                        "nics": [
                                                {
                                                        "order": 1,
                                                        "netId": "cloudcenter-188704:cloudcenter",
                                                        "id": "cloudcenter",
                                                        "allocatePublicIp": "false"
                                                }
                                        ],
                                        "instance": "g1-small"
                                }
                        }
                }
        ],
        "timeZone": "GMT+10:00"
}

EOM

RESULT=0

echo "Creating job in CloudCenter"
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
      echo "Correct content received"
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

echo "Stopping stack ..."
curl -s -k -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" -u ${CCC_USERNAME}:${CCC_KEY}  "${CCC_URL}/v2/jobs/${JOB_ID}"

echo "Exiting with result $RESULT"
exit $RESULT


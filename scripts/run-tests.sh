#!/bin/sh

echo "Executing run-tests.sh in ccc-wordpress"
echo "Using CCC_URL $CCC_URL, CCC_USERNAME $CCC_USERNAME and CCC_KEY $CCC_KEY"

echo "Using Git branch: GIT_BRANCH=$GIT_BRANCH GIT_LOCAL_BRANCH=$GIT_LOCAL_BRANCH"

cat > /tmp/json << EOM
{
        "appId": "31",
        "appVersion": "2",
        "name": "${BUILD_TAG}",
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
                                "value": "35.190.44.42"
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
                                "value": "1904e9f4-0f3b-4407-9fbe-565384c7ed17"
                        },
                        {
                                "name": "GIT_TAG",
                                "value": "${GIT_LOCAL_BRANCH}"
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
                                        "instance": "f1-micro"
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
                                        "instance": "f1-micro"
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
                                        "instance": "f1-micro"
                                }
                        }
                }
        ],
        "timeZone": "UTC"
}
EOM


echo "Creating job in CloudCenter"
CREATE_RESULT=`curl -s -k -X POST -H "Accept: application/json" -H "Content-Type: application/json" -u ${CCC_USERNAME}:${CCC_KEY} -d @/tmp/json "${CCC_URL}/v2/jobs"` 

echo "Result of submit job API call: '${CREATE_RESULT}'"
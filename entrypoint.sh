#!/bin/sh -l

sourceDirectory=$1
platform=$2
platformVersion=$3

echo
if [ -n "${sourceDirectory}" ]
then
    sourceDirectory="$PWD/$sourceDirectory"
    echo "Relative path to source directory provided -- the following directory will be built: '${sourceDirectory}'"
else
    sourceDirectory=$PWD
    echo "No source directory provided -- the root of the repository ('GITHUB_WORKSPACE' environment variable) will be built: '${sourceDirectory}'"
fi

echo
mkdir -p /tmp/oryx/platform
mkdir -p ${sourceDirectory}/out
oryxCommand="oryx build ${sourceDirectory} -i /tmp/oryx/platform -o ${sourceDirectory}/out"
echo

if [ -n "${platform}" ]
then
    echo "Platform provided: '${platform}'"
    oryxCommand="${oryxCommand} --platform ${platform}"
else
    echo "No platform provided -- Oryx will enumerate the source directory to determine the platform."
fi

echo

if [ -n "${platformVersion}" ]
then
    echo "Platform version provided: '${platformVersion}'"
    oryxCommand="${oryxCommand} --platform-version ${platformVersion}"
else
    echo "No platform version provided -- Oryx will determine the version."
fi

oryxCommand="${oryxCommand} --enable-dynamic-install"

echo
echo "Running command '${oryxCommand}'"

if [ -z "$ORYX_DISABLE_TELEMETRY" ] || [ "$ORYX_DISABLE_TELEMETRY" == "false" ]; then
    url="https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/jobs"
    json=$(curl -X GET "${url}")
    startTime=${json#*Build*/appservice-build@*,}
    startTime=$(echo "${startTime}"| sed 's/,/\n/g' | grep "started_at" | awk '{print $2}' | sed -n '1p')
    endTime=${json#*Build*/appservice-build@*,}
    endTime=$(echo "${endTime}" | sed 's/,/\n/g' | grep "completed_at" | awk '{print $2}' | sed -n '1p')
    export GITHUB_ACTIONS_BUILD_IMAGE_PULL_START_TIME=$startTime
    export GITHUB_ACTIONS_BUILD_IMAGE_PULL_END_TIME=$endTime
fi

eval $oryxCommand
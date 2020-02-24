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
oryxCommand="oryx build ${sourceDirectory}"

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

echo
echo "Running command '${oryxCommand}'"

url="https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/jobs"

json=$(curl -X GET "${url}")

#Extracts substring starting with '/appservice-build@'
#Then gets startTime and endTime within the first step.
startTime=${json#*Build*/appservice-build@*,}
startTime=$(echo "${startTime}"| sed 's/,/\n/g' | grep "started_at" | awk '{print $2}' | sed -n '1p')
endTime=${json#*Build*/appservice-build@*,}
endTime=$(echo "${endTime}" | sed 's/,/\n/g' | grep "completed_at" | awk '{print $2}' | sed -n '1p')

echo "The start time of action build is ${startTime}."
echo "The end time of action build is ${endTime}."

export GITHUB_ACTIONS_BUILD_START_TIME=$startTime
export GITHUB_ACTIONS_BUILD_END_TIME=$endTime

eval $oryxCommand
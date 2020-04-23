#!/bin/bash
set -e

checkArg() {
    # Check if the input has content and is not just whitepsace or is empty
    case $1 in
        (*[![:blank:]]*) echo "$1";;
        (*) echo ""
    esac
}

getAbsolutePath(){
    local path="$1"

    if [ -z "$path" ]; then
        echo "$PWD"
    fi

    # Check if the path is relative or absolute.
    # If relative path is given, create an absolute path
    case $path in
        /*) echo $path ;;
        *) echo "$PWD/$path" ;;
    esac
}

sourceDirectory=$(checkArg "$1")
platform=$(checkArg "$2")
platformVersion=$(checkArg "$3")
outputDirectory=$(checkArg "$4")

echo
if [ -z "$sourceDirectory" ]
then
    sourceDirectory="$PWD"
    echo "No source directory was provided -- the root of the repository ('GITHUB_WORKSPACE' environment variable) will be built: '$sourceDirectory'"
else
    sourceDirectory=$(getAbsolutePath "$sourceDirectory")
    echo "Source directory was provided. Following directory will be built: '$sourceDirectory'"
fi

oryxCommand="oryx build $sourceDirectory"

if [ -z "$outputDirectory" ]
then
    echo "No output directory was provided"
else
    outputDirectory=$(getAbsolutePath "$outputDirectory")
    oryxCommand="$oryxCommand -o $outputDirectory"
    echo "Output directory was provided: '$outputDirectory'"
fi

if [ -z "$platform" ]
then
    echo "No platform provided -- Oryx will enumerate the source directory to determine the platform."
else
    echo "Platform provided: '$platform'"
    oryxCommand="$oryxCommand --platform $platform"
fi

if [ -z "$platformVersion" ]
then
    echo "No platform version provided -- Oryx will determine the version."
else
    echo "Platform version provided: '$platformVersion'"
    oryxCommand="$oryxCommand --platform-version $platformVersion"
fi

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

echo
echo "Running command '$oryxCommand'"
eval $oryxCommand

# GitHub Action for building Azure Web Apps

![V1_BuildAndDeploy_PythonApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V1_BuildAndDeploy_PythonApp_ToAzureWebApp/badge.svg?branch=master)
![V1_BuildAndDeploy_PhpApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V1_BuildAndDeploy_PhpApp_ToAzureWebApp/badge.svg?branch=master)
![V1_BuildAndDeploy_NodeApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V1_BuildAndDeploy_NodeApp_ToAzureWebApp/badge.svg?branch=master)
![V1_BuildAndDeploy_AspNetCoreApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V1_BuildAndDeploy_AspNetCoreApp_ToAzureWebApp/badge.svg?branch=master)
![V2Beta_BuildAndDeploy_PythonApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V2Beta_BuildAndDeploy_PythonApp_ToAzureWebApp/badge.svg?branch=master)
![V2Beta_BuildAndDeploy_NodeApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V2Beta_BuildAndDeploy_NodeApp_ToAzureWebApp/badge.svg?branch=master)
![V2Beta_BuildAndDeploy_AspNetCoreApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V2Beta_BuildAndDeploy_AspNetCoreApp_ToAzureWebApp/badge.svg?branch=master)
![V2_BuildAndDeploy_AspNetCoreReactApp_ToAzureWebApp](https://github.com/MicrosoftOryx/githubactions-samples/workflows/V2_BuildAndDeploy_AspNetCoreReactApp_ToAzureWebApp/badge.svg?branch=master)

With the Azure App Service Actions for GitHub, you can automate your workflow to deploy [Azure Web Apps](https://azure.microsoft.com/en-us/services/app-service/web/) using GitHub Actions.

Get started today with a [free Azure account](https://azure.com/free/open-source)!

A repo for [Sample apps and sample workflows](https://github.com/MicrosoftOryx/githubactions-samples).

This repository contains the GitHub Action for [building Azure Web Apps on Linux](./action.yml) using the [Oryx](https://github.com/microsoft/Oryx) build system. Currently, the following platforms can be built using this GitHub Action:

- .NET Core
- Node
- PHP
- Python

If you are looking for a GitHub Action to deploy your Azure Web App, consider using [`azure/webapps-deploy`](https://github.com/Azure/webapps-deploy).

The definition of this GitHub Action is in [`action.yml`](./action.yml).

V2 version [`v2`](https://github.com/Azure/appservice-build/tree/v2) is released. It's using a [`new dockerfile for GitHub Actions`](https://github.com/microsoft/Oryx/blob/master/images/build/GitHubActions.Dockerfile
) to significantly reduce the time for building your app.

# End-to-End Sample Workflows

## Dependencies on other GitHub Actions

- [`actions/checkout`](https://github.com/actions/checkout)
  - Checkout your Git repository content into the GitHub Actions agent

## Other GitHub Actions

- [`azure/webapps-deploy`](https://github.com/Azure/webapps-deploy)
  - Deploy a web app to Azure

### Sample workflow to build a web app

The following is a sample of a workflow that builds a web app in a repository whenever a commit is pushed:

```
on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Cloning repository
        uses: actions/checkout@v1

      - name: Building web app
        uses: azure/appservice-build@v2
        with:
          platform: <PLATFORM_NAME>
          platform-version: <PLATFORM_VERSION>
          source-directory: <SOURCE_DIR>
          output-directory: <OUTPUT_DIR>
```

### Sample workflow to build and deploy an Azure Web App

The following is a sample workflow that builds a web app in a repository and then deploys it to Azure whenever a commit is pushed:

```
on: push

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Cloning repository
        uses: actions/checkout@v1

      - name: Building web app
        uses: azure/appservice-build@v2
        with:
          platform: <PLATFORM_NAME>
          platform-version: <PLATFORM_VERSION>
          source-directory: <SOURCE_DIR>
          output-directory: <OUTPUT_DIR>

      - name: Deploying web app to Azure
        uses: azure/webapps-deploy@v1
        with:
          app-name: <WEB_APP_NAME>
          publish-profile: ${{ secrets.AZURE_WEB_APP_PUBLISH_PROFILE }}
```

The following variable should be replaced in your workflow:

- `<PLATFORM_NAME>`
    - Programming platform used by the web app that's being deployed, **optional**.

- `<PLATFORM_VERSION>`
    - Version of programming platform used by the web app, **optional**.
    - Oryx will determine the version from source files if version was not set.
    - Default version of each platform if version was not set and Oryx couldn't determine version :
      - .NET Core 3.1
      - Node 12.16
      - PHP 7.3
      - Python 3.8

- `<SOURCE_DIR>`
    - Relative path (within the repo) to the source directory of the web app that's being deployed, **optional**.

- `<OUTPUT_DIR>`
    - Directory where the build output has to be put, **optional**.

- `<WEB_APP_NAME>`
    - Name of the web app that's being deployed

The following variable should be set in the GitHub repository's secrets store:

- `AZURE_WEB_APP_PUBLISH_PROFILE`
    - The contents of the publish profile file (`.publishsettings`) used to deploy the web app; for more information on setting this secret, please see the [`azure/webapps-deploy`](https://github.com/Azure/webapps-deploy) action

# Privacy

For more information about Microsoft's privacy policy, please see the [`PRIVACY.md`](./PRIVACY.md) file.

# Security

Microsoft takes the security of our software products and services seriously, which includes all source code repositories managed through our GitHub organizations, which include [Microsoft](https://github.com/Microsoft), [Azure](https://github.com/Azure), [DotNet](https://github.com/dotnet), [AspNet](https://github.com/aspnet), [Xamarin](https://github.com/xamarin), and [our GitHub organizations](https://opensource.microsoft.com/).

For more information about Microsoft's privacy policy, please see the [`SECURITY.md`](./SECURITY.md) file.

## Disable Data Collection

To disable this GitHub Action from collecting any data, please set the environment variable `ORYX_DISABLE_TELEMETRY` to `true`, as seen below:

```
- name: Building web app
  uses: azure/appservice-build@v2
  env:
    ORYX_DISABLE_TELEMETRY: true
```

# Contributing

For more information on contributing to this project, please see the [`CONTRIBUTING.md`](./CONTRIBUTING.md) file.

# License

For more information on contributing to this project, please see the [`LICENSE.md`](./LICENSE.md) file.

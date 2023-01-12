# GitHub Action for building Azure Web Apps

With the Azure App Service Actions for GitHub, you can automate your workflow to deploy
[Azure Web Apps](https://azure.microsoft.com/en-us/services/app-service/web/) using GitHub Actions.

A repo for [Sample apps and sample workflows](https://github.com/MicrosoftOryx/githubactions-samples).

This repository contains the GitHub Action for [building Azure Web Apps on Linux](./action.yml) using the
[Oryx](https://github.com/microsoft/Oryx) build system. Currently, the following platforms can be built using this
GitHub Action:

- Golang
- Java
- .NET Core
- Node
- PHP
- Python
- Ruby

If you are looking for a GitHub Action to deploy your Azure Web App, consider using
[`azure/webapps-deploy`](https://github.com/Azure/webapps-deploy).

If you are looking for a GitHub Action to build and deploy Azure Container Apps, consider using
[`azure/container-apps-deploy-action`](https://github.com/Azure/container-apps-deploy-action)

The definition of this GitHub Action is in [`action.yml`](./action.yml).

# End-to-End Sample Workflows

## Dependencies on other GitHub Actions

- [`actions/checkout`](https://github.com/actions/checkout)
  - Checkout your Git repository content into the GitHub Actions agent

## Other GitHub Actions

- [`azure/webapps-deploy`](https://github.com/Azure/webapps-deploy)
  - Deploy a web app to Azure

- [`azure/container-apps-deploy-action`](https://github.com/Azure/container-apps-deploy-action)
  - Build and deploy an Azure Container App

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
        uses: azure/appservice-build@v3
        with:
          platform: <PLATFORM_NAME>
          platform-version: <PLATFORM_VERSION>
          source-directory: <SOURCE_DIR>
          output-directory: <OUTPUT_DIR>
```

### Sample workflow to build and deploy an Azure Web App

The following is a sample workflow that builds a web app in a repository and then deploys it to Azure whenever a commit
is pushed:

```
on: push

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Cloning repository
        uses: actions/checkout@v1

      - name: Building web app
        uses: azure/appservice-build@v3
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

The following variables should be replaced in your workflow:

- `<PLATFORM_NAME>`
  - Programming platform used by the web app that's being deployed
  - **Optional** - Oryx will detect the provided application's platform if not provided

- `<PLATFORM_VERSION>`
  - Version of programming platform used by the web app
  - **Optional** - Oryx will determine the version from source files if version was not set.
  - The following are the default versions used per platform if a version cannot be detected by Oryx:
    - Golang 1.18
    - Java 11
    - .NET 6.0
    - Node 16
    - PHP 8.0
    - Python 3.8
    - Ruby 2.7

- `<SOURCE_DIR>`
  - Relative path (within the repo) to the source directory of the web app that's being deployed
  - **Optional** - The value of `GITHUB_WORKSPACE` environment variable will be used if not provided

- `<OUTPUT_DIR>`
  - The directory where the build output will be copied to
  - **Optional** - The build output will not be copied to a separate directory if not provided

- `<WEB_APP_NAME>`
  - Name of the web app that's being deployed
  - Used _only_ for the `azure/webapps-deploy` GitHub Action

The following variable should be set in the GitHub repository's secrets store:

- `AZURE_WEB_APP_PUBLISH_PROFILE`
    - The contents of the publish profile file (`.publishsettings`) used to deploy the web app; for more information on
    setting this secret, please see the [`azure/webapps-deploy`](https://github.com/Azure/webapps-deploy) action

# Privacy

For more information about Microsoft's privacy policy, please see the [`PRIVACY.md`](./PRIVACY.md) file.

# Security

Microsoft takes the security of our software products and services seriously, which includes all source code
repositories managed through our GitHub organizations, which include [Microsoft](https://github.com/Microsoft),
[Azure](https://github.com/Azure), [DotNet](https://github.com/dotnet), [AspNet](https://github.com/aspnet),
[Xamarin](https://github.com/xamarin), and [our GitHub organizations](https://opensource.microsoft.com/).

For more information about Microsoft's privacy policy, please see the [`SECURITY.md`](./SECURITY.md) file.

## Disable Data Collection

To disable this GitHub Action from collecting any data, please set the environment variable `ORYX_DISABLE_TELEMETRY` to
`true`, as seen below:

```
- name: Building web app
  uses: azure/appservice-build@v3
  env:
    ORYX_DISABLE_TELEMETRY: true
```

# Contributing

For more information on contributing to this project, please see the [`CONTRIBUTING.md`](./CONTRIBUTING.md) file.

# License

For more information on contributing to this project, please see the [`LICENSE.md`](./LICENSE.md) file.

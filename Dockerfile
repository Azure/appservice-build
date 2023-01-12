FROM mcr.microsoft.com/oryx/build:github-actions-debian-bullseye-20230111.1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

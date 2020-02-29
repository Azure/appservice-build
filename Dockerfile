FROM mcr.microsoft.com/oryx/build:github-actions

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]
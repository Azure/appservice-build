FROM mcr.microsoft.com/oryx/build:github-actions-20200623.3

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

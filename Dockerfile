FROM mcr.microsoft.com/oryx/build:github-actions-20210225.2

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

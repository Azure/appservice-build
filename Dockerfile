FROM mcr.microsoft.com/oryx/build:github-actions-20201015.1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

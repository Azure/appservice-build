FROM mcr.microsoft.com/oryx/build:github-actions-20200706.2

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

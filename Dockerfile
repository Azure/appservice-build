FROM mcr.microsoft.com/oryx/build:github-actions-20200421.4

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]
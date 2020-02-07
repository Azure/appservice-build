FROM mcr.microsoft.com/oryx/build:latest

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]
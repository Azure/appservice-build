FROM mcr.microsoft.com/oryx/build:20200312.2

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

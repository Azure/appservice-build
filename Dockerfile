FROM mcr.microsoft.com/oryx/build:20200311.3

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

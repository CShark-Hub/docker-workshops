FROM mcr.microsoft.com/dotnet/core/sdk:3.0

COPY ./MyDemoApp /src

WORKDIR /src

RUN dotnet restore

RUN dotnet publish -c Release -o /ouput

WORKDIR /ouput

CMD [ "dotnet", "./MyDemoApp.dll" ]

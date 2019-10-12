FROM mcr.microsoft.com/dotnet/core/sdk:3.0

WORKDIR /src

COPY ./MyDemoApp/*.csproj /src/

RUN dotnet restore

COPY ./MyDemoApp /src

RUN dotnet publish -c Release -o /ouput

WORKDIR /ouput

CMD [ "dotnet", "./MyDemoApp.dll" ]

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build

WORKDIR /src

COPY ./MyDemoApp/*.csproj /src/

RUN dotnet restore

COPY ./MyDemoApp /src

RUN echo 'TEST' \
    && dotnet publish -c Release -o /output

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0

WORKDIR /demo-app

COPY --from=build /output ./

EXPOSE 80

CMD [ "dotnet", "./MyDemoApp.dll" ]

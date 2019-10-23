FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build

WORKDIR /src

COPY ./MyDemoApp/*.csproj /src/

RUN dotnet restore

COPY ./MyDemoApp /src

RUN echo 'TEST' \
    && dotnet publish -c Release -o /output

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0

ENV ASPNETCORE_ENVIRONMENT=Production \
    LOG_DIR=/var/log/demo-app

COPY /docker/src /

WORKDIR /demo-app

COPY --from=build /output ./

EXPOSE 80

VOLUME [ "${LOG_DIR}" ]

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "dotnet", "./MyDemoApp.dll" ]

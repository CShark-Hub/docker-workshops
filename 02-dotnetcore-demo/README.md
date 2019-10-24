# Cookbook

## Commands

### Build

Build image (use cache if available)

```console
docker build -t docker-demo -f .\Dockerfile .
```

Build image (no cache)

```console
docker build -t docker-demo --no-cache -f .\Dockerfile .
```

### Run - Development

Run container in Development mode

```console
docker run --rm -ti -p 8080:80 --name my-webapp -e ASPNETCORE_ENVIRONMENT=Development docker-demo
```

Run container in Production mode

```console
mkdir -p .\data\logs
docker run --rm -ti -p 8080:80 --name my-webapp -e ASPNETCORE_ENVIRONMENT=Production -v $PWD\data\logs:/var/log/demo-app docker-demo
```

### Run - Production

Create volume

```console
docker volume create my-webapp-logs
```

Run container

```console
docker run -d -p 8080:80 --name my-webapp -e ASPNETCORE_ENVIRONMENT=Production -v my-webapp-logs:/var/log/demo-app docker-demo
```

Check logs

```console
docker logs my-webapp
```

Check logs (follow)

```console
docker logs -f my-webapp
```

Check data stored in volume

```console
docker exec my-webapp cat /var/log/demo-app/general.log
```

Check data stored in volume

```console
docker run --rm -v my-webapp-logs:/tmp/volume alpine cat /tmp/volume/general.log
```

Cleanup

```console
docker stop my-webapp
docker rm my-webapp
docker volume rm my-webapp-logs
```

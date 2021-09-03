# [humiu/debug](https://hub.docker.com/r/humiu/debug) - Docker image for debugging

This docker image is a collection of tools to debug and analyze any environment where containers are able to run (e.g. Kubernetes).

### Build the docker image

```bash
DOCKER_USER_NAME=<your docker username>
docker build -t $DOCKER_USER_NAME/debug .
```

### Test the docker image

```bash
docker run -ti --rm $DOCKER_USER_NAME/debug
```

### Push the debug image to docker hub

```bash
docker push $DOCKER_USER_NAME/debug
```

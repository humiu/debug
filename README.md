# [humiu/debug](https://hub.docker.com/r/humiu/debug) - Docker image for debugging

This docker image is a collection of tools to debug and analyze any environment where containers are able to run (e.g. Kubernetes).

## Usage

The following command will launch a debug container in your Kubernetes cluster and attach to it.  
Just change the `<NAMESPACE>` placeholder to a namespace of your choice.

```bash
kubectl run -n <NAMESPACE> --image=humiu/debug --rm -it debug
```

## Create your own "debug" image

If you want to customize this image, just clone or fork this repository and change the [`Dockerfile`](Dockerfile) according to your needs.

Then build the image and push it to a container registry.

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

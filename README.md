# k8s-containers-rebuild

This repo is aimed at building / rebuilding upstream containers using github actions. 

It supports building for `dockerhub` and `quay.io` using a templated workflow

## Requisites

### DockerHub

Secrets to login in dockerhub are required in the settings of this repo

* DOCKERHUB_USERNAME
* DOCKERHUB_TOKEN

### Quay.io

Secrets to login in dockerhub are required in the settings of this repo

* QUAYIO_USERNAME
* QUAYIO_TOKEN

## Setting up a new container to build

The directory in which the `Dockerfile` is created will determine the registry where the build image is pushed

`docker/<REPO_NAME>/<IMAGE_NAME>/`

2 Files are required in each directory 
* Dockerfile
* env
  * this file **must** contain a comma separated list of tags to name the image

The context of docker build is always set to the directory containing the Dockerfile

## Generating workflows

`./generate-workflows.sh`

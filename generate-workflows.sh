#!/bin/bash
generate_workflow() {
  DOCKERFILE_NAME="$1"
  TYPE="$2"
 
  CONTEXT_PATH=$(dirname "$DOCKERFILE_NAME")
  IMAGE_NAME="$TYPE / $(echo "$CONTEXT_PATH" | tr '/' ' ' | awk '{print $2" "$3}')"
  WORKFLOW_FILE_NAME="on-push-main-$(echo "$CONTEXT_PATH" | tr '/' '-').yml"

  TEMPLATES=()
  TEMPLATES+=(".github/templates/on-push-main-PRE.yml")

  if [[ "x$TYPE" == "xdocker" ]]; then
    TEMPLATES+=(".github/templates/dockerhub-registry.yml")
  elif [[ "x$TYPE" == "xquay" ]]; then
    TEMPLATES+=(".github/templates/quay-registry.yml")
  fi

  TEMPLATES+=(".github/templates/build-publish.yml")

  echo "Generating $WORKFLOW_FILE_NAME"

	cat $(echo "${TEMPLATES[*]}") | CONTEXT_PATH=${CONTEXT_PATH} IMAGE_NAME=${IMAGE_NAME} envsubst > ".github/workflows/$WORKFLOW_FILE_NAME"
}

docker_workflows() {
	find docker/ -type f -name Dockerfile | while read -r f; do
    generate_workflow "$f" "docker"
	done
}

quay_workflows() {
	find quay/ -type f -name Dockerfile | while read -r f; do
    generate_workflow "$f" "quay"
	done
}

rm -rf .github/workflows/*
docker_workflows
quay_workflows

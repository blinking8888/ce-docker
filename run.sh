#!/bin/sh

CONTAINER_NAME=${CONTAINER_NAME:-"compiler-explorer"}
CE_PORT_NUMBER=${CE_PORT_NUMBER:-10240}
CE_STORAGE_DIR=${CE_STORAGE_DIR:-ce-data}
CE_COMPILERS_VOLUME=${CE_COMPILERS_VOLUME:-ce-compilers}
CE_CONFIG_DIR=${CE_CONFIG_DIR:-./config}
CE_IMAGE_NAME=${CE_IMAGE_NAME:-"compiler-explorer:latest"}

docker run --rm --name $CONTAINER_NAME -it \
	-v $CE_STORAGE_DIR:/ce-data \
	-v $CE_CONFIG_DIR:/app/etc/config:ro \
	-v $CE_COMPILERS_VOLUME:/opt/compiler-explorer \
	-p $CE_PORT_NUMBER:10240 \
	$CE_IMAGE_NAME 

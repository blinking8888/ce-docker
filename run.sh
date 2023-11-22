#!/bin/sh

CONTAINER_NAME=${CONTAINER_NAME:-"compiler-explorer"}
CE_PORT_NUMBER=${CE_PORT_NUMBER:-10240}
CE_STORAGE_DIR=${CE_STORAGE_DIR:-./data}
CE_CONFIG_DIR=${CE_CONFIG_DIR:-./compiler-explorer/config}
CE_IMAGE_NAME=${CE_IMAGE_NAME:-"compiler-explorer:latest"}

docker run --rm --name $CONTAINER_NAME -it \
	-v $CE_STORAGE_DIR:/opt/compiler-explorer/lib/storage/data \
	-v $CE_CONFIG_DIR:/opt/compiler-explorer/etc/config \
	-p $CE_PORT_NUMBER:10240 \
	$CE_IMAGE_NAME

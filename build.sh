#!/bin/bash

docker build \
        --build-arg="BASE_DISTRO=bookworm-slim" \
        --build-arg="NODE_MAJOR_VERSION=20" \
        --build-arg="ASM_PARSER_VERSION=v0.9" \
        --build-arg="COMPILER_EXPLORER_VERSION=gh-9590" \
        -t ce:latest \
	.

ARG BASE_IMAGE=20-bookworm-slim

FROM node:${BASE_IMAGE}

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make \
    gcc g++ clang

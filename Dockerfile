######################################################################
# Compiler Explorer Docker Image Builder
######################################################################
ARG BASE_DISTRO=bookworm-slim
ARG NODE_MAJOR_VERSION=20
######################################################################
# Node Source
######################################################################
FROM node:${NODE_MAJOR_VERSION}-${BASE_DISTRO} AS node-src

######################################################################
# Rust Tools Source
######################################################################
FROM rust:1-slim-bookworm as rust-src

RUN apt-get update && \
	apt-get install -y git

WORKDIR /usr/src
RUN git clone --depth 1 https://github.com/compiler-explorer/tools.git /usr/src/tools
RUN cd /usr/src/tools/rust && \
	cargo build --release --locked && \
	mv target/release/rustfilt /usr/bin/rustfilt

######################################################################
# Node Source
######################################################################
FROM debian:bookworm-slim AS asm-parser

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	wget ca-certificates xz-utils

ARG ASM_PARSER_VERSION=v0.9

WORKDIR /tmp/
RUN wget \
	https://github.com/compiler-explorer/asm-parser/releases/download/${ASM_PARSER_VERSION}/asm-parser.tar.xz
RUN tar xfv ./asm-parser.tar.xz -C /tmp

# Base Image (gcc, g++, clang, gosu)
######################################################################
FROM debian:${BASE_DISTRO} AS base

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	g++ gcc clang git gosu && \
	rm -rf /var/lib/apt/lists && \
	apt-get clean

# Just get the `node` executable.  We don't need `npm`, `yarn`, etc.
COPY --from=node-src /usr/local/bin/node /usr/bin
RUN chmod +x /usr/bin/node
COPY --from=asm-parser /tmp/asm-parser /usr/bin/asm-parser
COPY --from=rust-src /usr/local/cargo/bin/rustfmt /usr/bin/rustfmt
COPY --from=rust-src /usr/bin/rustfilt /usr/bin/rustfilt

######################################################################
# Builder for CE Infra and Compiler Explorer itself
######################################################################
FROM node:${NODE_MAJOR_VERSION}-${BASE_DISTRO} AS ce-builder

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	git build-essential \
	make file python3 python3-pip \
	curl ca-certificates rsync

######################################################################
# Builds Compiler Explorer
######################################################################

FROM ce-builder AS ce-build
ARG COMPILER_EXPLORER_VERSION="gh-9590"
RUN git clone \
	--branch ${COMPILER_EXPLORER_VERSION} \
	--depth 1 https://github.com/compiler-explorer/compiler-explorer.git \
	/usr/src/compiler-explorer

WORKDIR /usr/src/compiler-explorer
RUN --mount=type=cache,target=/root/.npm make prebuild && npm cache clean --force

######################################################################
# Final Image
######################################################################
FROM base AS final

RUN useradd -l -M ce
RUN mkdir -p /opt

# We run from /app and not /opt/compiler-explorer.  /opt/compiler-explorer are for
# the compilers which the config files point to and it is an extra step to rename those
COPY --chown=ce:ce --from=ce-build  /usr/src/compiler-explorer /app

WORKDIR /app
COPY ./config/c++.local.properties ./etc/config/c++.local.properties
COPY ./config/c.local.properties ./etc/config/c.local.properties
COPY ./config/rust.local.properties ./etc/config/rust.local.properties
COPY ./config/compiler-explorer.local.properties ./etc/config/compiler-explorer.local.properties
RUN chown ce:ce /app

EXPOSE 10240

# Where links will be stored
VOLUME /ce-data
RUN mkdir /ce-data && chown ce:ce /ce-data

# Custom configuration for compilers so we don't need to rebuild the Docker image
VOLUME /app/etc/config

# Compilers
VOLUME /opt/compiler-explorer

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENV NODE_ENV=production
COPY ./entrypoint.sh .
RUN chmod +x entrypoint.sh

USER ce
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "node", "./out/dist/app.js", "--webpackContent", "./out/webpack/static", "--language", "c,c++,rust" ]


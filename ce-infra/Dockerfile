######################################################################
# Compiler Explorer Docker Image Builder
######################################################################
ARG BASE_DISTRO=bookworm-slim

######################################################################
# Node Source
######################################################################
FROM debian:${BASE_DISTRO}

######################################################################
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	git build-essential \
	make file python3 python3-pip \
	curl ca-certificates && \
	rm -rf /var/lib/apt/lists && \
	apt-get clean

######################################################################
# Builds the Infra part.
# This is the base image for downloading and extracting the compilers
# from the Amazon server
######################################################################
ARG INFRA_VERSION="main"
RUN git clone -b ${INFRA_VERSION} \
	--depth 1 \
	https://github.com/compiler-explorer/infra.git \
	/usr/src/infra

WORKDIR /usr/src/infra
RUN make ce
RUN mkdir /opt/compiler-explorer
RUN useradd -s /bin/bash -M ce
RUN chown ce:ce /opt/compiler-explorer

USER ce
VOLUME /opt/compiler-explorer
ENTRYPOINT [ "/usr/src/infra/bin/ce_install" ]
CMD [ "--help" ]

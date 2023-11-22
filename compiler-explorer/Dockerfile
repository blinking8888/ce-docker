ARG BASE_IMAGE=20-bookworm-slim

FROM ce-infra:latest as ce_infra
FROM gcc:latest as gcc
FROM clang:latest as clang

FROM node:${BASE_IMAGE}

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make \
    gcc clang

ENV NODE_ENV production
COPY --chown=nobody:nogroup --from=ce_infra /usr/src/compiler-explorer /opt/compiler-explorer
COPY --chown=nobody:nogroup --from=ce_infra /usr/bin/dumb-init /opt/compiler-explorer
COPY --chown=nobody:nogroup --from=gcc /opt/compiler-explorer /opt/compiler-explorer
COPY --chown=nobody:nogroup --from=clang /opt/compiler-explorer /opt/compiler-explorer
COPY --chown=nobody:nogroup ./config/c++.local.properties /opt/compiler-explorer/etc/config/c++.local.properties
COPY --chown=nobody:nogroup ./config/c.local.properties /opt/compiler-explorer/etc/config/c.local.properties
COPY --chown=nobody:nogroup ./config/compiler-explorer.local.properties /opt/compiler-explorer/etc/config/compiler-explorer.local.properties

WORKDIR /opt/compiler-explorer

EXPOSE 10240

VOLUME /opt/compiler-explorer/lib/storage/data
VOLUME /opt/compiler-explorer/etc/config

USER nobody
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENV EXTRA_ARGS='--language "c,c++"'

CMD [ "make", "run-only" ]

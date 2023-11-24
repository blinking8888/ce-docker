FROM ce-infra:latest as ce_infra
FROM ce-base:latest as ce_base
FROM ce-gcc:latest as gcc
FROM ce-clang:latest as clang
FROM ce-rust:latest as rust

FROM ce_base

ENV NODE_ENV production
COPY --chown=nobody:nogroup --from=ce_infra /usr/src/compiler-explorer /opt/compiler-explorer
COPY --chown=nobody:nogroup --from=ce_infra /usr/bin/dumb-init /opt/compiler-explorer
COPY --chown=nobody:nogroup --from=gcc /opt/compiler-explorer /opt/compiler-explorer
COPY --chown=nobody:nogroup --from=clang /opt/compiler-explorer /opt/compiler-explorer
COPY --chown=nobody:nogroup --from=rust /opt/compiler-explorer /opt/compiler-explorer

COPY --chown=nobody:nogroup ./config/c++.local.properties /opt/compiler-explorer/etc/config/c++.local.properties
COPY --chown=nobody:nogroup ./config/c.local.properties /opt/compiler-explorer/etc/config/c.local.properties
COPY --chown=nobody:nogroup ./config/rust.local.properties /opt/compiler-explorer/etc/config/rust.local.properties
COPY --chown=nobody:nogroup ./config/compiler-explorer.local.properties /opt/compiler-explorer/etc/config/compiler-explorer.local.properties

WORKDIR /opt/compiler-explorer

EXPOSE 10240

VOLUME /opt/compiler-explorer/lib/storage/data
VOLUME /opt/compiler-explorer/etc/config

USER nobody
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENV EXTRA_ARGS='--language "c,c++,rust"'

CMD [ "make", "run-only" ]

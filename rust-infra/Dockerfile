FROM rust:1-slim-bookworm

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	gosu

VOLUME /opt/compiler-explorer

COPY entrypoint.sh /bin/entrypoint.sh
COPY cp_with_path.sh /bin/cp_with_path.sh
RUN chmod +x /bin/entrypoint.sh /bin/cp_with_path.sh

RUN useradd -l -M ce

USER ce
RUN mkdir -p /tmp/cargo
RUN mkdir -p /tmp/rustup

WORKDIR /tmp/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV RUSTUP_HOME=/tmp/rustup

ENTRYPOINT [ "/bin/entrypoint.sh" ]


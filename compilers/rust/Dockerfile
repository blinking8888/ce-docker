FROM ce-infra:latest

ARG RUST_VERSIONS="1.66.0 1.74.0"

WORKDIR /usr/src/infra

VOLUME /opt/data

# RUN ./bin/ce_install add-top-rust-crates
# RUN ./bin/ce_install generate-rust-props && mv ./props /opt/data/
ENV RUST_HOME=/opt/compiler-explorer/rust
ENV RUSTUP_HOME=$RUST_HOME/.rustup
ENV CARGO_HOME=$RUST_HOME/.cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup.rs && \
	sh ./rustup.rs -y \
	--default-toolchain none --profile minimal \
	--target "aarch64-unknown-linux-gnu" \
	--target "armv7-unknown-linux-gnueabihf"

RUN $CARGO_HOME/bin/rustup toolchain install --profile minimal ${RUST_VERSIONS}

# Build rustfilt for demangling
RUN git clone --depth 1 https://github.com/compiler-explorer/tools.git /usr/src/tools
RUN mkdir -p ${RUST_HOME}/tools
RUN . ${CARGO_HOME}/env; \
	cd /usr/src/tools/rust && \
	cargo build --release --locked && \
	mv target/release/rustfilt ${RUST_HOME}/tools/

RUN mv ${RUSTUP_HOME}/toolchains/* ${RUST_HOME}/
RUN mv ${CARGO_HOME}/bin/rustfmt ${RUST_HOME}/tools/
RUN rm -fr ${CARGO_HOME}
RUN rm -fr ${RUST_HOME}/toolchains/stable-*


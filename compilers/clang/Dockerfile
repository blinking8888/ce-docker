FROM ce-infra:latest

ARG CLANG_VERSION="10.0.1"

WORKDIR /usr/src/infra

RUN ./bin/ce_install install clang ${CLANG_VERSION}

ENTRYPOINT zsh

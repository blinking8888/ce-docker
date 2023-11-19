FROM ce-infra:latest

ARG ARM_GCC_VERSION="9.5.0"
ARG X86_GCC_VERSION="9.5.0"

WORKDIR /usr/src/infra

RUN ./bin/ce_install install x86 gcc ${X86_GCC_VERSION}
RUN ./bin/ce_install install arm gcc ${ARM_GCC_VERSION}
RUN ./bin/ce_install install arm64 gcc ${ARM_GCC_VERSION}

ENTRYPOINT zsh

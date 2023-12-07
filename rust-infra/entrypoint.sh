#!/bin/bash

# IF container starts with root user,
if [ "$(id -u)" = "0" ]; then
    exec gosu rustup toolchain install --profile minimal $@
fi

# ELSE we just run CMD if container starts as appuser
rustup toolchain install --profile minimal $@

cd $RUSTUP_HOME/toolchains
mkdir -p /opt/compiler-explorer/rust
find . -name rustc -type f -exec /bin/cp_with_path.sh {} \;
find . -name lib -type d -exec /bin/cp_with_path.sh {} \;


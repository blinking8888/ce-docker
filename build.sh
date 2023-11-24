#!/bin/bash

docker build \
	--build-arg="NODE_VERSION=20-bookworm-slim" \
	-t ce-base:latest \
	./compiler-explorer/base

docker build \
	--build-arg="NODE_VERSION=20-bookworm-slim" \
	--build-arg="COMPILER_EXPLORER_VERSION=gh-9590" \
	-t ce-infra:latest \
	./ce-infra/

docker build \
       --build-arg="ARM_GCC_VERSION=9.5.0" \
       --build-arg="X86_GCC_VERSION=9.5.0" \
       -t ce-gcc:latest \
       ./compilers/gcc/

docker build \
       --build-arg="CLANG_VERSION=10.0.1" \
       -t ce-clang:latest \
       ./compilers/clang/

docker build \
       --build-arg="RUST_VERSIONS=1.66.0 1.74.0" \
       -t ce-rust:latest \
       ./compilers/rust/

docker build \
       -t compiler-explorer:latest \
       ./compiler-explorer/

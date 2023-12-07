#!/bin/bash

compiler=$@
storage=ce-compilers

docker run --rm -v $storage:/opt/compiler-explorer -it ce-infra $compiler

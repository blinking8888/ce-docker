# Compiler Explorer in Docker

[Compiler Explorer](https://godbolt.org) is a very useful tool.  You might want to run it privately whether for educational purposes or have it installed within the bounds of your enterprise firewall.

The goal of this repository is to be able to do a custom install of Compiler Explorer with only the compilers that you wish to install.  Installing all the compilers that Compiler Explorer supports would require a big amount of storage but it is up to you.

## Installation

You will need to install Docker to build and run Compiler Explorer using this code.  You will need the [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/).

### Compiler Explorer

To run Compiler Explorer, you can either invoke `run.sh`:

```bash
./run.sh
```
or use `docker compose`

```bash
docker compose up
```

### Compilers and Tools

Any compiler and tools that Compiler Explorer supports can be installed using the `ce-infra` docker image.
Using `docker compose`:

```bash
cd ce-infra
docker compose build ce-infra
docker compose run ce-infra install <compiler>
```
CE Infra wil try its best to match the compiler with the string that you specified in compiler.  For example, to install an x86 gcc compiler with versio 11.3.0, you can do:

```bash
docker compose run ce-infra install x86 gcc 11.3.0
```

#### Rust Compilers

A special docker image is created for the sole purpose of a 'minimal' install of Rust compilers.  As of this writing, Compiler Explorer only needs the `rustc` executable and a couple of tools - `rustfmt` and `rustfilt`.  We're extracting just those and copy it to the `ce-compilers` volume.

## Docker Configuration

### Docker Compose

Feel free to modify the `docker-compose.yml` files so you can automatically install the compilers and run Compiler Explorer.  Sample compiler installations are included here for reference and is intended to just demonstrate how it can be done.

### Volumes

#### `ce-compilers`

This volume contains all the compilers that is installed.  To install the compilers, you will need to make use of the `ce-infra` image which is under the `ce-infra` directory.

This is mounted at `/opt/compiler-explorer` in the compiler-explorer container.

#### `ce-data`

`ce-data` contains the runtime data the compiler-explorer container saves.  This is typically the data that is needed to retrieve the links that are shared so it can be retrieved later even when the container is restarted.

This is mounted in `/ce-data`.

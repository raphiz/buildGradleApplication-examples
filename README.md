# `buildGradleApplication` Examples

This repository contains example usages of the [`buildGradleApplication`](https://github.com/raphiz/buildGradleApplication) Nix builder function.

## Run the examples

```bash
nix run -j 15 .#helloWorld
nix run -j 15 .#springBoot
```

## Re generate verification metadata

```bash
pushd hello-world
update-verification-metadata
popd

pushd spring-boot
update-verification-metadata
popd
```

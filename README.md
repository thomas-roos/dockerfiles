# dockerfiles
This repo is to share docker files for random purpose - usually yocto build demos

## general usage

### build docker container
`build -t yocto-build`

### run docker container
`docker run -it yocto-build`

### build yocto
`cd yocto`

`source poky/oe-init-build-env`

`bitbake aws-lc`

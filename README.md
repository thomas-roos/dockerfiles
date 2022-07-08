# dockerfiles
This repo is to share docker files for random purpose - usually yocto build demos

## usage
If not specified different.

### build
`docker build -t yocto-build .`

### run
`docker run -it yocto-build`

### build yocto
`cd yocto`

`source poky/oe-init-build-env`

`bitbake XXX`

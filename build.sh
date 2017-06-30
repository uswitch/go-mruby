#!/bin/bash

MRUBY_COMMIT=e4fa59f5
MRUBY_CONFIG=./mruby_build.rb

case "${OSTYPE}" in
    linux*)
        DIST="linux"
        ;;
    darwin*)
        DIST="darwin"
        ;;
    *)
        echo "Couldn't work out DIST"
        exit 1
        ;;
esac

tmp_dir="$(mktemp -d)"

git clone https://github.com/mruby/mruby.git "${tmp_dir}"

pushd "${tmp_dir}"

git reset --hard
git clean -fdx
git checkout ${MRUBY_COMMIT}

make

popd

cp ${tmp_dir}/build/host/lib/*.a lib/${DIST}/
cp -r ${tmp_dir}/include .

#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

if [[ $(uname) != *"Darwin"* ]]; then
  pip install tensorflow
else
  pip install tensorflow-macos
fi

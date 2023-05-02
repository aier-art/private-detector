#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

if [[ $(uname) != *"Darwin"* ]]; then
  pip install tensorflow
  if grep -q 'arm' /proc/cpuinfo || grep -q 'aarch64' /proc/cpuinfo; then
    apt-get install -y openjdk-19-jdk
    wget https://github.com/bazelbuild/bazel/releases/download/7.0.0-pre.20230420.2/bazel-7.0.0-pre.20230420.2-linux-arm64 -O /usr/local/bin/bazel
    chmod +x /usr/local/bin/bazel
    git clone https://github.com/tensorflow/addons.git
    cd addons
    python3 ./configure.py
    bazel build build_pip_pkg
    bazel-bin/build_pip_pkg artifacts
    pip install artifacts/tensorflow_addons-*.whl
    cd ..
    rm -rf addons
  else
    pip install tensorflow-addons
  fi
else
  pip install tensorflow-macos
fi

pip install -r requirements.txt

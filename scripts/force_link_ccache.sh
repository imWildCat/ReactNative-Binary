#!/usr/bin/env bash

command="$1"

if [ "$command" == "clean" ]; then
  unlink /usr/local/bin/gcc
  unlink /usr/local/bin/g++
  unlink /usr/local/bin/cc
  unlink /usr/local/bin/c++
  unlink /usr/local/bin/clang
  unlink /usr/local/bin/clang++
else
  ln -s ccache /usr/local/bin/gcc
  ln -s ccache /usr/local/bin/g++
  ln -s ccache /usr/local/bin/cc
  ln -s ccache /usr/local/bin/c++
  ln -s ccache /usr/local/bin/clang
  ln -s ccache /usr/local/bin/clang++
fi

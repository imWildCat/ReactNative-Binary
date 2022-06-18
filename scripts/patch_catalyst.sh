#!/usr/bin/env bash

sed -i '' 's/typedef uint8_t clockid_t;//' Pods/RCT-Folly/folly/portability/Time.h

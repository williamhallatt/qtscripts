#!/bin/bash

# Script for buliding Qt 5.x.
#
# Clean the repo VERY thoroughly.
git submodule foreach --recursive "git clean -dfx"

# Pull in all changes.
git pull
git submodule sync
git submodule update --recursive

# Reconfigure Qt.
./configure -developer-build -opensource -nomake examples -nomake tests -no-gtkstyle -confirm-license

# Make the magic happen.
make -j 4
make docs


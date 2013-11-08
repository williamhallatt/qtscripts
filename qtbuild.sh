#!/bin/bash
git submodule foreach --recursive "git clean -dfx"
git pull
git submodule sync
git submodule update --recursive
./configure -developer-build -opensource -nomake examples -nomake tests -no-gtkstyle -confirm-license
make -j 4
make docs


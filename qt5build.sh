#!/bin/bash

#================================================================================
# Copyright (c) 2012 - 2013 by William Hallatt.
# 
# This script is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this script (GNUGPL.txt).  If not, see
#
#                    <http://www.gnu.org/licenses/>
# 
# Should you wish to contact me for whatever reason, please do so via:
#
#                 <http://www.goblincoding.com/contact>
# 
#================================================================================

# Script for buliding Qt 5.x. This script should be executed from within your Qt
# source directory (where you cloned the repo).

# Uncomment the following three commands if this is the first time you are building
# Qt from source.  Remember to comment it out again for subsequent builds! :)
# sudo apt-get install build-essential perl python git
# sudo apt-get install "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev
# ./init-repository

make clean

# Clean the repo VERY thoroughly.
git submodule foreach --recursive "git clean -dfx"

# Pull in all changes.
git pull
git submodule sync
git submodule update --recursive

# Reconfigure Qt for developer build.
./configure -developer-build -opensource -nomake examples -nomake tests -no-gtkstyle -confirm-license

# Reconfigure Qt for release.
#./configure -opensource -warnings-are-errors -no-compile-examples -nomake tests -no-gtkstyle -confirm-license

# Make the magic happen.
make 

# For release builds you need to install.
# sudo make install

# Update documentation.
make docs
sudo make install_docs

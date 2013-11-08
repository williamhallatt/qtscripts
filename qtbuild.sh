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


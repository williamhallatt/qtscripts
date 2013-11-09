#!/bin/sh

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

# This script will install all "not found" dependencies for ALL libraries 
# that exist within the directory from where it is executed. 

# All of the packages thus installed can be removed through running the generated 
# "removedep.sh" script if you wish to undo these changes.

removescript=removedep.sh
> $removescript
echo "#!/bin/sh" >> $removescript

# For each library in this directory...
for lib in `ls -F | grep -v @ | grep *.so`
do
  # Determine the dependencies, find only those that are not on the system, exclude all Qt5 libraries,
  # print the name of the library (not full path) and extract the package name from the .so name itself.
  lddquery=`ldd $lib | grep -i "not found" | grep -i -v qt5 | awk '{print $1}' | sed 's/\(^.*\)\.so.*$/\1/'`
  #echo $lddquery

  echo "Installing dependencies for library: "$lib
  #echo $lib

  for dep in $lddquery
  do
    echo "Found dependency: "$dep

    # Query apt-cache for the relevant package, excluding dev and dbg versions.
    packagequery=`apt-cache search $dep | grep -v dev | grep -v dbg | awk '{print $1}'`
    echo "Querying package list for: "

    sudo apt-get install $packagequery
    echo "Installing: "$packagequery
    echo "sudo apt-get remove $packagequery" >> $removescript
  done
done

chmod u+x $removescript

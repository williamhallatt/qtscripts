#!/bin/sh

installfile=installed.txt
> $installfile

# For each library in this directory...
for lib in `ls -F | grep -v @ | grep *.so`
do
  # Determine the dependencies, find only those that are not on the system, exclude all Qt5 libraries,
  # print the name of the library (not full path) and extract the package name from the .so name itself.
  lddquery=`ldd $lib | grep -i "not found" | grep -i -v qt5 | awk '{print $1}' | sed 's/\(^.*\)\.so.*$/\1/'`
  #echo $lddquery
  
  echo "Installing dependencies for library: "$lib >> $installfile
  #echo $lib
  
  for dep in $lddquery
  do
    echo "Found dependency: "$dep

    # Query apt-cache for the relevant package, excluding dev and dbg versions.
    packagequery=`apt-cache search $dep | grep -v dev | grep -v dbg | awk '{print $1}'`
    echo "Querying package list for: "$packagequery
    
    sudo apt-get install $packagequery
    echo "Installing: "$packagequery >> $installfile
  done
done

#!/bin/bash

print(){
 echo "[dots updater] $1"
}

path=$(pwd)
cd  "$(dirname $(readlink -f $0))"
cp ~/.zshrc .
print ".zshrc updated"
cp ~/.xinitrc .
print ".xinitrc updated"
cd $path
print "returned into $path" 


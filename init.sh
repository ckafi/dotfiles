#!/bin/bash
# run this script to initialize this repo

mkdir backup/
mkdir undo/
mkdir swap/
git submodule init
git submodule update

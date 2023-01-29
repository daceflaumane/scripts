#!/bin/bash

# Uzgenereto failu direktorija
dir_path=io_files

# Dzest/nedzest
read -p "Vai velaties dzest $dir_path un ta saturu (y/n)? " confirm

if [ "$confirm" == "y" ]; then
  # Izdzest
  rm -rf "$dir_path"
  echo "$dir_path un saturs ir izdzests."
else
  echo "Dzesana atcelta."
fi

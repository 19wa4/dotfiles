#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C

cd
wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
bash Anaconda3-2022.05-Linux-x86_64.sh
. "${HOME}"/.bashrc
conda config --append channels conda-forge
conda config --set auto_activate_base false
conda update --all
# conda env create -y -f foo.yml
conda info -e
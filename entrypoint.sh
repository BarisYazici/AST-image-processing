#!/bin/bash

source /workspaces/src/run-build.sh
sudo apt-get install -y python3-pip python3-opencv
pip3 install jupyterlab
cd /workspaces/src/python-module/ && ./install_astimp_python_module.sh
echo LD_LIBRARY_PATH=/workspaces/src/build/astimplib:$LD_LIBRARY_PATH >> /home/user/.bashrc
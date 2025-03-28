#!/bin/bash

# Update system packages
sudo apt update && sudo apt install -y python3 python3-pip git wget libgl1-mesa-glx libglib2.0-0 jupyterlab

# Set up Miniconda in your home directory
CONDA_INSTALL_DIR=$HOME/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $CONDA_INSTALL_DIR
rm Miniconda3-latest-Linux-x86_64.sh

# Add conda to current session (without affecting .bashrc yet)
export PATH="$CONDA_INSTALL_DIR/bin:$PATH"

# Initialize conda for bash
$CONDA_INSTALL_DIR/bin/conda init bash

# Source .bashrc for immediate use or use conda directly
eval "$($CONDA_INSTALL_DIR/bin/conda shell.bash hook)"

# Create the conda environment
conda create -n spm python=3.10 -y

# Define a function to run commands in the conda environment
function run_in_conda() {
  conda run -n spm --no-capture-output bash -c "$*"
}

# Clone SPM repository
git clone https://github.com/civitai/SPM
cd SPM/

# Install requirements within the conda environment
run_in_conda "pip install -r ./requirements.txt"

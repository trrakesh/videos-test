#!/bin/bash

# Update system
sudo dnf update -y

sudo dnf groupinstall "Development Tools" -y
# Install dependencies
sudo dnf install python3-devel python3-pip git wget -y
sudo dnf install libGL libgomp opencv -y

# Create and activate virtual environment
python3 -m venv ~/mmpose_env
source ~/mmpose_env/bin/activate

pip install wheel

# Install PyTorch (CPU version - modify for GPU)
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install MMCV and dependencies
pip install -U openmim
mim install mmengine
#mim install "mmcv>=2.0.0"
#mim install "mmdet>=3.0.0"

# Install MMPose
mim install "mmpose>=1.0.0"

# Verify installation
python -c "import mmpose; print('MMPose version:', mmpose.__version__)"

echo "MMPose installation complete!"

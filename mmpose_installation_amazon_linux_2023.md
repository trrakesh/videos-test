# Installing MMPose on Amazon Linux 2023

This guide provides step-by-step instructions for installing MMPose on Amazon Linux 2023.

## Prerequisites

Before installing MMPose, ensure you have:
- Python 3.8 or later
- CUDA (if using GPU)
- Git

## Step 1: Update System and Install Dependencies

```bash
# Update system packages
sudo dnf update -y

# Install development tools
sudo dnf groupinstall "Development Tools" -y

# Install Python development packages
sudo dnf install python3-devel python3-pip -y

# Install additional dependencies
sudo dnf install git wget curl -y
sudo dnf install libGL libgomp -y
```

## Step 2: Set Up Python Virtual Environment (Recommended)

```bash
# Install virtualenv if not already installed
pip3 install virtualenv --break-system-packages

# Create a virtual environment
python3 -m venv ~/mmpose_env

# Activate the virtual environment
source ~/mmpose_env/bin/activate
```

## Step 3: Install PyTorch

Install PyTorch according to your CUDA version. For CPU-only installation:

```bash
# CPU version
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
```

For GPU with CUDA 11.8:

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

For GPU with CUDA 12.1:

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

Verify PyTorch installation:

```bash
python -c "import torch; print(torch.__version__)"
```

## Step 4: Install MMCV

MMPose requires MMCV (MMDetection Computer Vision library):

```bash
# Install mmcv using mim
pip install -U openmim
mim install mmengine
mim install "mmcv>=2.0.0"
```

Alternatively, you can install mmcv directly:

```bash
pip install mmcv>=2.0.0 -f https://download.openmmlab.com/mmcv/dist/cpu/torch2.0/index.html
```

(Replace `cpu` and `torch2.0` with your CUDA version and PyTorch version if needed)

## Step 5: Install MMDetection (Optional but Recommended)

Some MMPose models depend on MMDetection:

```bash
mim install "mmdet>=3.0.0"
```

## Step 6: Install MMPose

### Option A: Install from pip (Stable Release)

```bash
mim install "mmpose>=1.0.0"
```

Or using pip directly:

```bash
pip install mmpose
```

### Option B: Install from Source (Latest Development Version)

```bash
# Clone the repository
git clone https://github.com/open-mmlab/mmpose.git
cd mmpose

# Install in editable mode
pip install -e .
```

## Step 7: Verify Installation

```bash
# Check MMPose version
python -c "import mmpose; print(mmpose.__version__)"

# Run a simple test
python -c "from mmpose.apis import init_model; print('MMPose successfully installed!')"
```

## Step 8: Download Demo Data (Optional)

To test MMPose with demo images:

```bash
# Download demo image
wget https://raw.githubusercontent.com/open-mmlab/mmpose/main/demo/resources/human-pose.jpg

# Download a pretrained model config and checkpoint
mim download mmpose --config td-hm_hrnet-w48_8xb32-210e_coco-256x192 --dest .
```

## Troubleshooting

### Issue: Missing OpenCV dependencies

```bash
sudo dnf install opencv opencv-devel -y
# Or install via pip
pip install opencv-python opencv-contrib-python
```

### Issue: CUDA-related errors

Ensure CUDA is properly installed and the CUDA version matches your PyTorch installation:

```bash
# Check CUDA version
nvcc --version
# or
nvidia-smi
```

### Issue: Import errors for mmcv

Make sure mmcv version is compatible:

```bash
pip uninstall mmcv mmcv-full -y
mim install "mmcv>=2.0.0"
```

### Issue: Permission denied errors

If you encounter permission issues, either:
- Use a virtual environment (recommended)
- Add `--user` flag to pip commands
- Use `sudo` (not recommended)

## Additional Notes

### For GPU Support on Amazon Linux 2023

If you're using GPU instances:

1. Install NVIDIA drivers:
```bash
sudo dnf install -y gcc kernel-devel-$(uname -r)
# Download and install NVIDIA driver from official website
```

2. Install CUDA Toolkit:
```bash
# Follow AWS documentation for installing CUDA on Amazon Linux 2023
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-nvidia-driver.html
```

### Using EC2 Deep Learning AMI

Consider using AWS Deep Learning AMI which comes with pre-installed:
- CUDA
- cuDNN
- PyTorch
- Other deep learning frameworks

This can significantly simplify the installation process.

## Quick Installation Script

Here's a complete script for quick installation:

```bash
#!/bin/bash

# Update system
sudo dnf update -y

# Install dependencies
sudo dnf install python3-devel python3-pip git wget -y
sudo dnf install libGL libgomp opencv -y

# Create and activate virtual environment
python3 -m venv ~/mmpose_env
source ~/mmpose_env/bin/activate

# Install PyTorch (CPU version - modify for GPU)
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install MMCV and dependencies
pip install -U openmim
mim install mmengine
mim install "mmcv>=2.0.0"
mim install "mmdet>=3.0.0"

# Install MMPose
mim install "mmpose>=1.0.0"

# Verify installation
python -c "import mmpose; print('MMPose version:', mmpose.__version__)"

echo "MMPose installation complete!"
```

Save this as `install_mmpose.sh`, make it executable with `chmod +x install_mmpose.sh`, and run with `./install_mmpose.sh`.

## References

- MMPose Documentation: https://mmpose.readthedocs.io/
- MMPose GitHub: https://github.com/open-mmlab/mmpose
- MMCV Documentation: https://mmcv.readthedocs.io/

conda create -n test_pose python=3.9 numpy=1.23.5 -c conda-forge -y
conda activate test_pose

conda install -c conda-forge pycocotools pillow matplotlib six -y
pip install \
  mmengine==0.10.7 \
  mmcv==2.1.0 \
  mmdet==3.3.0 \
  mmpose==1.3.2

pip install "opencv-python-headless<4.9"

pip install --no-cache-dir xtcocotools==1.13

python - <<'EOF'
import numpy as np
import cv2
import mmcv
import mmdet
import mmpose
import xtcocotools._mask
from pycocotools import mask
from PIL import Image

print("NumPy:", np.__version__)
print("OpenCV:", cv2.__version__)
print("MMCV:", mmcv.__version__)
print("MMDet:", mmdet.__version__)
print("MMPose:", mmpose.__version__)
print("🎉 ALL IMPORTS OK 🎉")
EOF

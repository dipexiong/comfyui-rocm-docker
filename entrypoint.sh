#!/bin/bash
COMFYUI_DIR="/comfyui"
VENV_DIR=$COMFYUI_DIR/venv

# Clone ComfyUI and Manager, if it does not exist yet
if [ ! -d "$COMFYUI_DIR/.git" ]; then
  echo "Cloning ComfyUI into volume..."
  git clone https://github.com/comfyanonymous/ComfyUI.git "$COMFYUI_DIR"
  git clone https://github.com/ltdrdata/ComfyUI-Manager "$COMFYUI_DIR"/custom_nodes/comfyui-manager
else
  echo "ComfyUI already initialized."
fi

echo "Creating/Opening virtual environment..."
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

echo "Installing PyTorch and dependencies..."
pip install --upgrade pip
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.2

echo "Installing ComfyUI requirements..."
pip install -r requirements.txt
pip install pyyaml

# Run ComfyUI
exec "$VENV_DIR/bin/python" main.py --lowvram
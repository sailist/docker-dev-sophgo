docker run -d --privileged \
    -p 0.0.0.0:8124:22 \
    -p 0.0.0.0:10124:10000 \
    -v $HOME/code:/workspace \
    -v $HOME/.vscode-server:/root/.vscode-server \
    --name tpu-mlir-dev-main tpu-mlir-custom:v1
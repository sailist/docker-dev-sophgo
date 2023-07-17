container_exists=$(docker ps -a --filter "name=tpu-mlir-dev-main" --format "{{.Names}}")

echo "recreate docker container"
# 如果容器存在，则删除
if [[ ! -z $container_exists ]]; then
    docker rm -f tpu-mlir-dev-main
fi

docker run -d --privileged \
    -p 0.0.0.0:8124:22 \
    -p 0.0.0.0:10124:10000 \
    -v $HOME/code:/workspace \
    -v $HOME/.vscode-server:/home/haozhe/.vscode-server \
    -v $HOME/.local/lib/python3.8/site-packages:/home/haozhe/.local/lib/python3.8/site-packages \
    --name tpu-mlir-dev-main tpu-mlir-custom


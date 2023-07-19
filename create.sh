CNAME=tpu-mlir-dev-main
WORKSPACE_DIR=$HOME

container_exists=$(docker ps -a --filter "name=$CNAME" --format "{{.Names}}")

# 如果容器存在，则删除
if [[ ! -z $container_exists ]]; then
    echo "recreate docker container"
    docker rm -f tpu-mlir-dev-main
fi

docker run -d --privileged \
    -p 0.0.0.0:8124:22 \
    -p 0.0.0.0:10124:10000 \
    -v $WORKSPACE_DIR:/workspace \
    -v $HOME/.vscode-server:$HOME/.vscode-server \
    -v $HOME/.local/:$HOME/.local/ \
    --name $CNAME tpu-mlir-custom


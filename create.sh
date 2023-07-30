if [ $# -gt 0 ]; then
  CNAME=$1
else
  CNAME=tpu-mlir-dev-main
fi

WORKSPACE_DIR=$HOME

container_exists=$(docker ps -a --filter "name=$CNAME" --format "{{.Names}}")

# 如果容器存在，则删除
if [[ ! -z $container_exists ]]; then
    echo "recreate docker container"
    docker rm -f $CNAME
fi

if [ ! -f "~/.vscode-server-docker" ]; then
    cp -r ~/.vscode-server ~/.vscode-server-docker
fi


docker run -d --privileged \
    -p 0.0.0.0:8124:22 \
    -p 0.0.0.0:10124:10000 \
    --ipc=host \
    -v $WORKSPACE_DIR:/workspace \
    -v $HOME/.vscode-server-docker:$HOME/.vscode-server \
    -v $HOME/.vscode-server-docker:/root/.vscode-server \
    -v $HOME/.local/lib:$HOME/.local/lib \
    --name $CNAME tpu-mlir-custom


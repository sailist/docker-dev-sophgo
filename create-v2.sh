if [ $# -gt 0 ]; then
  CNAME=$1
else
  CNAME=tpu-mlir-dev-v2.1
fi

WORKSPACE_DIR=$HOME/code

container_exists=$(docker ps -a --filter "name=$CNAME" --format "{{.Names}}")

# 如果容器存在，则删除
if [[ ! -z $container_exists ]]; then
    echo "recreate docker container"
    docker rm -f $CNAME
fi

if [ ! -d "~/.vscode-server-docker" ]; then
    cp -r ~/.vscode-server ~/.vscode-server-docker
fi


docker run -d --privileged \
    -p 0.0.0.0:8125:22 \
    -p 0.0.0.0:10125:10000 \
    --ipc=host \
    -v $WORKSPACE_DIR:/workspace \
    -v $HOME/.vscode-server-docker:$HOME/.vscode-server \
    -v $HOME/.vscode-server-docker:/root/.vscode-server \
    -v $HOME/.local/lib:$HOME/.local/lib \
    --name $CNAME tpu-mlir-custom:v2.1
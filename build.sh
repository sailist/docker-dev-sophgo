
mkdir -p ssh-config
if [ ! -f "ssh-config/id_rsa" ]; then
    ssh-keygen -t rsa -b 4096 -f ssh-config/id_rsa
fi

touch id_rsa.pub

docker build --build-arg USER_HOME=$HOME --build-arg USER=$USER -t tpu-mlir-custom:latest .


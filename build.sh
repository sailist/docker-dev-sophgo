
mkdir -p ssh-config
if [ ! -f "ssh-config/id_rsa" ]; then
    ssh-keygen -t rsa -b 4096 -f ssh-config/id_rsa
fi

# CURDATE=$(date +"%y%m%d%H%M")
docker build --build-arg USER_HOME=$HOME -t tpu-mlir-custom:latest .


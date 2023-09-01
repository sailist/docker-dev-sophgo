
mkdir -p ssh-config
if [ ! -f "ssh-config/id_rsa" ]; then
    ssh-keygen -t rsa -b 4096 -f ssh-config/id_rsa
fi

cp $HOME/.ssh/authorized_keys ./authorized_keys

GIT_USER=$(git config --get user.name)
GIT_EMAIL=$(git config --get user.email)


docker build \
--build-arg USER_HOME=$HOME \
--build-arg USER=$USER \
--build-arg GIT_USER=$GIT_USER \
--build-arg GIT_EMAIL=$GIT_EMAIL \
-t tpu-mlir-custom:v2.1 .


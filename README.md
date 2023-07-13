# clone
```
git clone https://github.com/sailist/docker-dev-sophgo
cd docker-dev-sophgo
```

# prepare id_rsa.pub


将本地 id_rsa.pub 上传到 repo 目录下

```diff
./
../
build.sh
create.sh
Dockerfile
.git/
.gitignore
+ id_rsa.pub
README.md
run_docker.sh
```

# custom environment

按自己需求更改 Dockerfile，如
```
RUN echo 'export PATH=$PATH:...' >> ~/.bashrc
```

# build

只需运行一次，创建镜像
```
bash build.sh
```

# create container

创建容器，根据需求创建
```
bash create.sh
```

# run

```
bash run_docker.sh
```


# directly connect ssh 

可以直接 ssh 连入 docker
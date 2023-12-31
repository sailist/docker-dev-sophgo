FROM sophgo/tpuc_dev:v3.1
# FROM sophgo/tpuc_dev:v2.1

ARG USER_HOME
ARG USER
ARG GIT_USER
ARG GIT_EMAIL

# configure user login
RUN useradd -ms /bin/bash ${USER} && usermod -aG sudo ${USER} && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

## configure passwd
RUN echo 'root:admin123' | chpasswd
RUN echo "${USER}:admin123" | chpasswd


# 
RUN apt-get update 


## configure login info
RUN touch /etc/motd

# configure ssh auto login
RUN apt-get install -y openssh-server openssh-client 
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

USER ${USER}
RUN mkdir -p ${USER_HOME}/.ssh
COPY id_rsa.pub /tmp/id_rsa.pub
COPY .vimrc /home/${USER}/.vimrc
COPY authorized_keys ${USER_HOME}/.ssh/authorized_keys
USER root

EXPOSE 22

# EXPOSE dev port
EXPOSE 8000
EXPOSE 8001
EXPOSE 8002
EXPOSE 8003
EXPOSE 10000
EXPOSE 10001
EXPOSE 10002
EXPOSE 10003


# custom environment
RUN echo 'source /workspace/vscode_workspace/expose_func.sh' >> ${USER_HOME}/.bashrc


# configure git
## lfs
RUN apt-get install -y git-lfs

## disable ssh verify (for gerrit)
RUN apt-get install git-core bash-completion

USER ${USER}
## name/email password config
RUN git config --global user.name $GIT_USER
RUN git config --global user.email $GIT_EMAIL
RUN git config --global http.sslVerify false
RUN git config --global credential.helper store
### support utf-8 log
RUN git config --global core.quotepath off 

USER root

# start ssh when docker started
CMD ["/usr/sbin/sshd", "-D"]
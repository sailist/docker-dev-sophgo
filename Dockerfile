FROM sophgo/tpuc_dev:latest

# configure custom environment
ARG USER_HOME

RUN useradd -ms /bin/bash haozhe && usermod -aG sudo haozhe && echo 'haozhe ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# configure passwd
RUN echo 'root:admin123' | chpasswd
RUN echo 'haozhe:admin123' | chpasswd

# configure login info
RUN touch /etc/motd

# configure ssh auto login

RUN apt-get update 
RUN apt-get install -y tmux openssh-server openssh-client 
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN apt-get install -y git-lfs

COPY ssh-config/id_rsa ${USER_HOME}/.ssh/id_rsa
COPY ssh-config/id_rsa.pub ${USER_HOME}/.ssh/id_rsa.pub
COPY id_rsa.pub /tmp/id_rsa.pub
# COPY root-ssh/ /etc/ssh/

RUN echo 'source /workspace/vscode_workspace/expose_func.sh' >> ${USER_HOME}/.bashrc

RUN mkdir -p ${USER_HOME}/.ssh && \ 
    chmod 600 ${USER_HOME}/.ssh/id_rsa && \
    chmod 600 ${USER_HOME}/.ssh/id_rsa.pub && \
    cat /tmp/id_rsa.pub >> ${USER_HOME}/.ssh/authorized_keys && \
    chmod 600 ${USER_HOME}/.ssh/authorized_keys && \
    chown haozhe ${USER_HOME}/.ssh/authorized_keys && \
    chown haozhe -R ${USER_HOME}/.ssh/ && \
    rm /tmp/id_rsa.pub
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


USER haozhe
RUN git config --global http.sslVerify false

# start ssh when docker started
CMD ["/usr/sbin/sshd", "-D"]
FROM sophgo/tpuc_dev:latest

# configure custom environment
ARG USER_HOME

RUN useradd -ms /bin/bash haozhe && usermod -aG sudo haozhe
RUN echo 'export PATH=$PATH:/workspace/vscode_workspace' >> ~/.bashrc
RUN echo 'mlir() { source mlir_envsetup.sh; }' >> ${USER_HOME}/.bashrc

# configure passwd
RUN echo 'root:admin123' | chpasswd
RUN echo 'haozhe:admin123' | chpasswd

# configure ssh auto login
RUN apt-get update && apt-get install -y tmux openssh-server openssh-client
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY ssh-config/id_rsa ${USER_HOME}/.ssh/id_rsa
COPY ssh-config/id_rsa.pub ${USER_HOME}/.ssh/id_rsa.pub
RUN chmod 600 ${USER_HOME}/.ssh/id_rsa && \
    chmod 600 ${USER_HOME}/.ssh/id_rsa.pub
    
COPY id_rsa.pub /tmp/id_rsa.pub
RUN mkdir -p ${USER_HOME}/.ssh && \
    cat /tmp/id_rsa.pub >> ${USER_HOME}/.ssh/authorized_keys && \
    chmod 600 ${USER_HOME}/.ssh/authorized_keys && \
    chown haozhe ${USER_HOME}/.ssh/authorized_keys && \
    rm /tmp/id_rsa.pub

RUN chown haozhe -R ${USER_HOME}/.ssh/ 
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

# start ssh when docker started
CMD ["/usr/sbin/sshd", "-D"]
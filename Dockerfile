FROM sophgo/tpuc_dev:latest

# configure custom environment
# RUN echo 'export PATH=$PATH:/workspace/vscode_workspace' >> ~/.bashrc

# configure passwd
RUN echo 'root:admin123' | chpasswd

# configure ssh auto login
RUN apt-get update && apt-get install -y tmux openssh-server openssh-client
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY id_rsa.pub /tmp/id_rsa.pub
RUN mkdir -p ~/.ssh && \
    cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 600 ~/.ssh/authorized_keys && \
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

# start ssh when docker started
CMD ["/usr/sbin/sshd", "-D"]
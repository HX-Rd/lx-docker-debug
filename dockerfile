# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Set the maintainer label
LABEL maintainer="git@euphoricmail.com"

# Update and upgrade apt-get
RUN apt-get update && apt-get upgrade -y

# Optional: Install any additional packages you need
RUN apt-get install -y vim
RUN apt-get install -y git-core
RUN apt-get install -y git

RUN git config --global user.name HX-Rd

RUN cd /root && \
    git clone https://github.com/HX-Rd/lx-pref && \
    rm -f /root/.vim && \
    rm -rf /root/lx-pref/.git && \
    cp -a /root/lx-pref/. /root && \
    chmod 644 /root/.bashrc && \
    cp -a /root/lx-pref/. /root && \
    chmod 644 /root/.bashrc && \
    rm -rf /root/lx-pref && \
    sh /root/.vim_runtime/bin/install 

RUN export VISUAL=vim
RUN export EDITOR="$VISUAL"


RUN curl -k -Ss https://raw.githubusercontent.com/HX-Rd/lx-docker-debug/master/install.sh >> install.sh ; chmod +x install.sh ; /root/install.sh ; source /root/.bashrc

# Set the default command to run when the container starts
CMD ["bash"]
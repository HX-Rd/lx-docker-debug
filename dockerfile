# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Set the maintainer label
LABEL maintainer="git@euphoricmail.com"

# Update and upgrade apt-get
RUN apt-get update && apt-get upgrade -y

# Optional: Install any additional packages you need
RUN apt-get install -y \
    vim \
    git-core \
    git \
    curl \
    tcpdump \
    iproute2 \
    iputils-ping \
    net-tools \
    dnsutils \
    curl \
    unzip \
    wget \
    apt-transport-https \
    software-properties-common 

RUN mkdir -p /opt/microsoft/powershell/7 \
    tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 \
    chmod +x /opt/microsoft/powershell/7/pwsh \
    ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh 

RUN git config --global user.name HX-Rd

RUN cd /root && \
    git clone https://github.com/HX-Rd/lx-docker-debug && \
    rm -f /root/.vim && \
    rm -rf /root/lx-docker-debug/.git && \
    cp -a /root/lx-docker-debug/. /root && \
    chmod 644 /root/.bashrc && \
    cp -a /root/lx-docker-debug/. /root && \
    chmod 644 /root/.bashrc && \
    rm -rf /root/lx-docker-debug && \
    sh /root/.vim_runtime/bin/install 

RUN mkdir /root/lx-docker-debug \
    git clone https://github.com/HX-Rd/lx-docker-debug.git /root/lx-docker-debug \
    find /root/lx-docker-debug/ -type f -iname "*.sh" -exec chmod +x {} \; \
    /root/lx-docker-debug/setup.sh

RUN curl -s https://ohmyposh.dev/install.sh | bash -s

RUN rm -rf /root/lx-docker-debug

RUN files=$(\ls -a $HOME/lx-pref) \
    backup_folder=$HOME/env-backup \
    mkdir root/env-backup \
    blacklist=( \
        '.' \
        '..' \
        '.git' \
        'setup.sh' \
        'install.sh' \
        'scripts' \
    ) \
    for file in $files \
    do \
        if [ -f $HOME/$file ] || [ -d $HOME/$file ] \
        then \
            if [[ ! " ${blacklist[@]} " =~ " ${file} " ]] \
            then \
                mv /root/$file $backup_folder/$file \
            fi \
        fi \
        if [[ ! " ${blacklist[@]} " =~ " ${file} " ]] \
        then \
            mv /root/lx-docker-debug/$file /root/$file \
    fi \
    done \
    echo "Done setting up environment"

RUN export VISUAL=vim
RUN export EDITOR="$VISUAL"


# Set the default command to run when the container starts
CMD ["bash"]
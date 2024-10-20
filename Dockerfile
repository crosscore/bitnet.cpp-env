FROM python:3.12-slim

RUN apt-get update && \
    apt-get install -y \
        git \
        cmake \
        clang \
        make \
        bash \
        build-essential \
        libc6-dev \
        libstdc++-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install huggingface_hub

WORKDIR /app

RUN git clone --recursive https://github.com/microsoft/BitNet.git

WORKDIR /app/BitNet

RUN pip3 install -r requirements.txt

# 改良済みのsetup_env.pyをcopy
COPY setup_env.py /app/BitNet/

COPY entrypoint.sh /app/BitNet/

# ENTRYPOINT ["./entrypoint.sh"]

RUN echo "alias ls='ls --color=auto'" >> ~/.bashrc && \
    echo "alias ll='ls -alF'" >> ~/.bashrc && \
    echo "export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> ~/.bashrc

CMD ["tail", "-f", "/dev/null"]

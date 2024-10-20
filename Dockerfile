FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y python3 python3-pip git cmake clang make bash && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install huggingface_hub

WORKDIR /app

RUN git clone --recursive https://github.com/microsoft/BitNet.git

WORKDIR /app/BitNet

RUN pip3 install -r requirements.txt

# 改良済みのsetup_env.pyをcopy
COPY setup_env.py /app/BitNet/

COPY entrypoint.sh /app/BitNet/

ENTRYPOINT ["./entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]

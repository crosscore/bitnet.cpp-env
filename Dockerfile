# bitnet.cpp-env/Dockerfile

FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y python3 python3-pip git cmake clang make && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install huggingface_hub

WORKDIR /app

RUN git clone --recursive https://github.com/microsoft/BitNet.git

WORKDIR /app/BitNet

RUN pip3 install -r requirements.txt

# 改良済みのsetup_env.pyをcopy
COPY setup_env.py /app/BitNet/

# setup_env.pyを実行（モデルが既に存在する場合はダウンロードと量子化をスキップ）
RUN python3 setup_env.py --hf-repo HF1BitLLM/Llama3-8B-1.58-100B-tokens -q i2_s

CMD ["tail", "-f", "/dev/null"]

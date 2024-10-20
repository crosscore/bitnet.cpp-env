# bitnet.cpp-env/Dockerfile

FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV MODEL_DIR=/app/models
ENV HF_REPO=HF1BitLLM/Llama3-8B-1.58-100B-tokens
ENV QUANT_TYPE=i2_s

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    clang \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY BitNet/requirements.txt /app/BitNet/requirements.txt

RUN pip install --upgrade pip && \
    pip install -r /app/BitNet/requirements.txt

COPY BitNet/ /app/BitNet/

RUN mkdir -p $MODEL_DIR

# Setting environment variables
ARG HF_REPO_ARG=HF1BitLLM/Llama3-8B-1.58-100B-tokens
ARG QUANT_TYPE_ARG=i2_s
ENV HF_REPO=${HF_REPO_ARG}
ENV QUANT_TYPE=${QUANT_TYPE_ARG}

# Downloading the model, quantizing it, and building the project
RUN python /app/BitNet/setup_env.py --hf-repo $HF_REPO --model-dir $MODEL_DIR --quant-type $QUANT_TYPE

ENV PATH="/app/BitNet/build/bin:${PATH}"

CMD ["tail", "-f", "/dev/null"]

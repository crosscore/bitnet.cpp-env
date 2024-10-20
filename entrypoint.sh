#!/bin/bash
set -e

# ログディレクトリの存在確認・作成
mkdir -p /app/BitNet/logs

# 環境設定スクリプトを実行
python3 setup_env.py --hf-repo HF1BitLLM/Llama3-8B-1.58-100B-tokens -q i2_s

# コンテナ起動後に実行するコマンドを引き継ぐ
exec "$@"

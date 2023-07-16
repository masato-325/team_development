#!/bin/bash
set -e

# server.pid ファイルが既に存在している場合は、削除
rm -f /myapp/tmp/pids/server.pid

# コンテナのメインプロセス（DockerfileでCMDとして設定されたもの）を実行
exec "$@"
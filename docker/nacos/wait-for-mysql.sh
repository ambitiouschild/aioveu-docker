#!/bin/bash
# 等待mysql服务可用，然后才继续执行

set -e

host="mysql"
port="3306"
timeout=60

echo "等待mysql服务在 $host:$port 上可用..."
while ! nc -z $host $port; do
  sleep 1
  timeout=$((timeout-1))
  if [ $timeout -eq 0 ]; then
    echo "等待mysql服务超时，退出。"
    exit 1
  fi
done

echo "mysql服务已可用，继续启动nacos..."
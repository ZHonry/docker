#!/bin/sh
set -e

IMAGE_NAME="jeesa/winbox"
DATE_TAG=$(date +%Y-%m-%d)

echo "🛠 构建镜像: ${IMAGE_NAME}"
docker build -t ${IMAGE_NAME}:latest-V4 -t ${IMAGE_NAME}:${DATE_TAG}-V4 .

echo "🚀 推送镜像到 Docker Hub..."
docker push --all-tags ${IMAGE_NAME}

echo "✅ 完成!"
echo "已推送以下标签:"
echo " - ${IMAGE_NAME}:latest-V4"
echo " - ${IMAGE_NAME}:${DATE_TAG}-V4"

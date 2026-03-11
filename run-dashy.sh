#!/usr/bin/env bash

CONFIG="$HOME/dashy/my-conf.yml"
CONTAINER_NAME="my-dashboard"
IMAGE="docker.io/lissy93/dashy:latest"

echo "Pulling latest image..."
sudo podman pull "$IMAGE"

echo "Checking for existing container..."
if sudo podman ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "Stopping container..."
    sudo podman stop "$CONTAINER_NAME"

    echo "Removing container..."
    sudo podman rm "$CONTAINER_NAME"
fi

echo "Starting new Dashy container..."
sudo podman run -d \
  -h 0.0.0.0 \
  -p 8080:8080 \
  -v "$CONFIG:/app/user-data/conf.yml:Z" \
  --name "$CONTAINER_NAME" \
  --restart=always \
  "$IMAGE"

echo "Done! Dashy available at http://localhost:8080"

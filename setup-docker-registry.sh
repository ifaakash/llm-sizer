#!/bin/bash

echo "––– Verify if registry is present or not –––"
existing_images=$(docker images --format '{{.Repository}}')

if echo $existing_images | grep -i "registry"; then
  echo "––– Registry image already exists –––"
else
 echo "––– pulling resistry image –––"
 docker pull registry:latest
fi

echo "––– SETTING UP REGISTRY ON PORT 5000 –––"
docker run -d -p 5000:5000 --name registry registry:latest 

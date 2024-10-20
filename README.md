## 👋 Welcome to docker 🚀  

Description  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update docker
```
  
## Install and run container
  
```shell
mkdir -p "$HOME/.local/share/srv/docker/docker/rootfs"
git clone "https://github.com/dockermgr/docker" "$HOME/.local/share/CasjaysDev/dockermgr/docker"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/docker/rootfs/." "$HOME/.local/share/srv/docker/docker/rootfs/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-docker \
--hostname docker \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-docker/rootfs/data:/data:z" \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-docker/rootfs/config:/config:z" \
-p 80:80 \
casjaysdevdocker/docker:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/docker
    container_name: casjaysdevdocker-docker
    environment:
      - TZ=America/New_York
      - HOSTNAME=docker
    volumes:
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-docker/rootfs/data:/data:z"
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-docker/rootfs/config:/config:z"
    ports:
      - 80:80
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/docker
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/docker" "$HOME/Projects/github/casjaysdevdocker/docker"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/docker"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  

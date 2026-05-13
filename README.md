## 👋 Welcome to docker 🚀  

docker README  
  
  
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
dockerHome="/var/lib/srv/$USER/docker/casjaysdevdocker/docker/docker/latest/rootfs"
mkdir -p "/var/lib/srv/$USER/docker/docker/rootfs"
git clone "https://github.com/dockermgr/docker" "$HOME/.local/share/CasjaysDev/dockermgr/docker"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/docker/rootfs/." "$dockerHome/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-docker-latest \
--hostname docker \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$dockerHome/data:/data:z" \
-v "$dockerHome/config:/config:z" \
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
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/docker/docker/latest/rootfs/data:/data:z"
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/docker/docker/latest/rootfs/config:/config:z"
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

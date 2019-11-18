

### docker

```
docker create \
  --name=quakejs \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Denver \
  -p 8989:8080 \
  -p 27960:27960 \
  -v $(pwd)/quakejs:/config \
  --restart unless-stopped \
  quakejs

  docker create --name=quakejs -e PUID=1000 -e PGID=1000 -e TZ=America/Denver -p 8989:8080 -p 27960:27960 -v $(pwd)/quakejs:/config --restart unless-stopped quakejs
```

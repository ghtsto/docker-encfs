# docker-encfs

Generate EncFS XML (encfs.xml) and password (encfspass) files at the bind mounted path.

```
docker run -it --rm \
    --privileged \
    --device /dev/fuse \
    --env ENCFS_PASS=password \
    --mount type=bind,src=${PWD},dst=/encfs \
    ghtsto/encfs:latest \
    generate-encfs &>/dev/null
```

# Dockerfile libvips on buster

```
docker pull debian:buster
docker build -t libvips-buster .
```

# filename encoding

```
docker run -it --rm -v $PWD:/data libvips-buster
vipsthumbnail --vips-info "中國人 русский.jpg" --size '400x400>' -o "400_400.png"
```


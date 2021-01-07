# ruby-vips for fedora 33

# Rebuild the image

```
docker pull fedora:33
docker build -t ruby-vips-fedora33 .
```

# Test

```
docker run -it --rm -v $PWD:/data ruby-vips-fedora33 ./thumb.rb
```




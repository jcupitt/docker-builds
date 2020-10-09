# ruby-vips on amazon linux

# Rebuild the image

```
docker pull lambci/lambda:build-ruby2.7
docker build -t ruby-vips-amazonlinux .
```

# Shell in image

```
docker run -it --rm ruby-vips-amazonlinux /bin/bash
```


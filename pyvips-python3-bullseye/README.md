# pyvips on py3.11 Debian bullseye

```shell
docker pull python:3.11-slim-bullseye
docker build -t pyvips-bullseye .
docker run -it --rm pyvips-bullseye /bin/bash
```

docker run --rm -t -v $PWD:/data pyvips-bullseye ./wobble.py test.jpg x.jpg


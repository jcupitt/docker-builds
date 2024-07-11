docker pull python:3.12-slim
docker build -t pyvips-bookworm .
docker run -rm -it pyvips-bookworm
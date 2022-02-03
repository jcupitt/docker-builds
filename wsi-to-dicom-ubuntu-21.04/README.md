# Build wsi-to-dicom-converter on ubuntu 21.04 

```
docker pull ubuntu:21.04
docker build -t wsi-to-dicom-ubuntu-21.04 .
```

```
docker run --rm -t \
		-v $PWD:/data \
		wsi-to-dicom-ubuntu-19.04 
```

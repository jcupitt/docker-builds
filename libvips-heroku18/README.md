# libvips on heroku 18

This uses platform libraries when we can. It builds to /usr/src/vips in the
container, so tar that up and send it off to s3 ready to deploy.

# Rebuild the image

	docker pull heroku/heroku:18

	docker run -it --rm heroku/heroku:18

	docker build -t libvips-heroku18 .



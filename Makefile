# rules to deploy data data and build the docker image
# CURDIR is set to the directory this file lives when make is called
# the .PHONY: declarations tell make that rule is not a file, just the name of a rule


# build cpu image
.PHONY: cpu_image
cpu_image:
	docker build -t division_detection:latest -f Dockerfile ${CURDIR}

# build gpu image
.PHONY: gpu_image
gpu_image:
	docker build -t division_detection:latest_gpu -f Dockerfile.gpu ${CURDIR}

.PHONY: tag_images
tag_images: cpu_image gpu_image
	docker tag division_detection:latest rueberger/division_detection:latest && \
	docker tag division_detection:latest_gpu rueberger/division_detection:latest_gpu

# push images
.PHONY: images
images: tag_images
	docker push rueberger/division_detection

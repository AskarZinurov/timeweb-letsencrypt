CURRENT_VERSION = "0.0.1"
IMAGE = "timeweb-getssl"

build:
	podman buildx build -f Containerfile -t ${IMAGE} -t ${IMAGE}:${CURRENT_VERSION} -t askarini/${IMAGE}:${CURRENT_VERSION} .

exec:
	podman run --secret timeweb-getssl-twcrc -v tmp:/home/getssl/.getssl --rm -it ${IMAGE}:${CURRENT_VERSION} /bin/bash

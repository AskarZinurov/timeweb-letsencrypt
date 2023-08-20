CURRENT_VERSION = "0.0.2"
IMAGE = "timeweb-getssl"

build:
	podman build -f Containerfile -t ${IMAGE} -t ${IMAGE}:${CURRENT_VERSION} .

release:
	podman build --platform=linux/amd64 --platform=linux/arm64 -f Containerfile --manifest askarini/${IMAGE}:${CURRENT_VERSION} .
	podman manifest push askarini/${IMAGE}:${CURRENT_VERSION}

exec:
	podman run -u root --secret timeweb-getssl-twcrc --name timeweb-getssl -v ./tmp:/getssl/.getssl --rm --entrypoint /bin/bash -it ${IMAGE}:${CURRENT_VERSION}

generate:
	rm pod.yml
	podman generate kube timeweb-getssl timeweb-getssl -f pod.yml

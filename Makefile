all: build

build: docker

include .env
export

docker: ##  Builds and pushes the application for amd64
	docker buildx build --no-cache=true \
		--add-host objects.githubusercontent.com:185.199.108.133 \
		--build-arg ALPINE_TOOLS_VERSION=$(ALPINE_TOOLS_VERSION) \
		--build-arg POLICY_CLI_VERSION=$(POLICY_CLI_VERSION) \
		--build-arg OPA_VERSION=$(OPA_VERSION) \
		--build-arg REGAL_VERSION=$(REGAL_VERSION) \
		--build-arg COSIGN_VERSION=$(COSIGN_VERSION) \
		--platform linux/amd64 -t mheers/opa-tools:$(OPA_VERSION) -t mheers/opa-tools:latest \
		--push .

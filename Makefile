.DEFAULT_GOAL := help

IMAGENAME = firebird25:latest
VOLUMENAME = /home/wacek/firebird-data
CONTAINERNAME = firebird25

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Main commands
build: ## Build image
	docker build \
		--no-cache \
		--tag $(IMAGENAME) \
		.

start: ## Start previously built image
	docker run \
 		--detach \
		--rm \
		--publish 3050:3050 \
		--publish 3051:3051 \
		--volume $(VOLUMENAME):/data \
		--name $(CONTAINERNAME) $(IMAGENAME)

stop: ## Stop environment
	docker stop $(CONTAINERNAME)

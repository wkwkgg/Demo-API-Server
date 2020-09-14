.DEFAULT_GOAL := help


###########################################################################################################
## variables
###########################################################################################################
export DOCKER=docker
export PROJECT_NAME=demo_api_server
export IMAGE_NAME=$(PROJECT_NAME)-image
export CONTAINER_NAME=$(PROJECT_NAME)-container
export DOCKERFILE=./docker/Dockerfile


###########################################################################################################
## general targets
###########################################################################################################
.PHONY: help
help: ## Display help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: init-docker
init-docker: ## Initialize docker image
	$(DOCKER) build -t $(IMAGE_NAME) -f $(DOCKERFILE) .

.PHONY: profile-docker
profile-docker: ## Show profile of this project
	@echo "CONTAINER_NAME: $(CONTAINER_NAME)"
	@echo "IMAGE_NAME: $(IMAGE_NAME)"

.PHONY: create-container
create-container: ## create docker container
	$(DOCKER) run -it -v $(PWD):/work --name $(CONTAINER_NAME) $(IMAGE_NAME)

.PHONY: clean-docker
clean-docker: clean-container clean-image ## Remove docker environment
	
.PHONY: clean-container
clean-container: ## Remove docker container
	$(DOCKER) rm $(CONTAINER_NAME)

.PHONY: clean-image
clean-image: ## Remove docker image
	$(DOCKER) image rm $(IMAGE_NAME)
.DEFAULT_GOAL := help


###########################################################################################################
## variables
###########################################################################################################
export DOCKER=docker
export PROJECT_NAME=demo_api_server
export IMAGE_NAME=$(PROJECT_NAME)-image
export CONTAINER_NAME=$(PROJECT_NAME)-container
export DOCKERFILE=./docker/Dockerfile
export HOST_PORT=8000
export CONTAINER_PORT=8000
export PYTHON=python3

###########################################################################################################
##  main targets
###########################################################################################################

.PHONY: run-server
run-server: ## Run API Server
	docker run -it --rm -v $(PWD):/work -p $(HOST_PORT):$(CONTAINER_PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME) $(PYTHON) ./scripts/main.py --port $(CONTAINER_PORT)

.PHONY: run-test
run-test: ## Run test script
	docker run -it --rm -v $(PWD):/work -p $(HOST_PORT):$(CONTAINER_PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME) pytest ./tests/test_main.py

.PHONY: run-lint
run-lint: ## Run linter (black)
	@docker run -v ${PWD}:/work --rm $(IMAGE_NAME) black .

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
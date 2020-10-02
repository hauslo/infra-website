
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
EXEC_DOCKER_COMPOSE=docker-compose -f test/docker-compose.yml
EXEC_TF=docker run --rm --name terraform -v $(ROOT_DIR):/test/module -v $(ROOT_DIR)/test:/test -w /test --network="host" hashicorp/terraform:light 
EXEC_CURL=docker run --rm --name curl --network="host" curlimages/curl:latest 

start:
	$(EXEC_DOCKER_COMPOSE) up -d --remove-orphans --no-recreate
	$(EXEC_TF) init

stop:
	$(EXEC_DOCKER_COMPOSE) kill
	$(EXEC_DOCKER_COMPOSE) down --volumes --remove-orphans

validate:
	$(EXEC_TF) validate

plan:
	$(EXEC_TF) plan

apply:
	$(EXEC_TF) apply -auto-approve

destroy:
	$(EXEC_TF) destroy -auto-approve

healthcheck:
	$(EXEC_CURL) http://localhost:4572/test/index.html 

test: validate apply healthcheck


.PHONY: start stop validate plan apply destroy healthcheck test
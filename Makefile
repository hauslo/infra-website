
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
EXEC_DOCKER_COMPOSE=docker-compose -f test/docker-compose.yml
EXEC_TF=docker run --rm --name terraform -v $(ROOT_DIR):/test/module -v $(ROOT_DIR)/test:/test -w /test --network="host" hashicorp/terraform:light 
EXEC_CURL=docker run --rm --name curl --network="host" curlimages/curl:latest 
EXEC_ALPINE=docker run --rm alpine:latest 

start:
	$(EXEC_DOCKER_COMPOSE) up -d --remove-orphans --no-recreate
	$(EXEC_TF) init

wait:
#	 docker run --rm --name wait -e TARGETS=localhost:4566,localhost:4572 --network="host" waisbrot/wait # cleaner but not working, localstack exposes the ports before being ready
#    docker logs localstack | grep -q "Ready." && # todo: loop until Ready. is in localstack logs
	$(EXEC_ALPINE) sleep 5s

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

auto-test: start wait test stop

.PHONY: start wait stop validate plan apply destroy healthcheck test auto-test
include .env

setup: build create compose

build:
	$(eval BUILD_ARGS= $(shell cat .env | while read line; do echo "--build-arg $$line"; done; echo ""; echo ""))
	docker build $(BUILD_ARGS) --tag phoenix:$(TAG) .

create:
	docker run -it -v $(shell pwd):$(APP_HOME) -u $(shell id -u):$(shell id -g) phoenix:$(TAG) mix phx.new $(APP_NAME) --install $(PHX_NEW_PARAMS)

compose:
	cp docker-compose.yml $(APP_NAME)

cli:
	docker run --interactive --tty --rm --volume $(shell pwd):$(APP_HOME)  phoenix:$(TAG)
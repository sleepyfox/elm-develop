.PHONY: run build repl test echo
PWD = $(shell pwd)
VERSION = 0.16.0
USER = $(shell whoami)
APP = "elm"

echo:
	echo $(USER) $(APP)

build:
	docker build --build-arg user=$(USER) \
	  -t sleepyfox/$(APP):$(VERSION) .

run:
	docker run -it \
	-v $(PWD):/home/$(APP) \
	sleepyfox/$(APP):$(VERSION) bash

repl:
	docker run -it --rm \
	-v $(PWD):/home/$(APP) \
	sleepyfox/$(APP):$(VERSION) elm-repl

test:
	docker run -it --rm \
	-v $(PWD):/home/$(APP) \
	sleepyfox/$(APP):$(VERSION) ???

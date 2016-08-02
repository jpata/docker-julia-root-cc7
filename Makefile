TAG=`git rev-parse --short HEAD`

build:
	docker build -t jpata/julia:v0.5_root_cxx_$(TAG) .

run:
	docker run --privileged -ti jpata/julia:v0.5_root_cxx_$(TAG) /bin/bash

pull:
	docker pull jpata/julia:v0.5_root_cxx_$(TAG) 

push:
	docker push jpata/julia:v0.5_root_cxx_$(TAG)

.PHONY: all run

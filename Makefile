build:
	docker build -t jpata/julia:v0.5_root_cxx .

run:
	docker run -ti jpata/julia:v0.5_root_cxx /bin/bash

.PHONY: all run

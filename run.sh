#!/bin/bash

# docker run --env-file .user_variables -v $(pwd)/builds:/builds `docker build -q .`
docker run -it --env-file .user_variables -v $(pwd)/builds:/builds `docker build -q .` bash


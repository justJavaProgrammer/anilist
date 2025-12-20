#!/bin/bash

VERSION=3

docker tag anime-rest-api:${VERSION} us-west1-docker.pkg.dev/integral-zephyr-481413-k6/dev/anime-rest-api:${VERSION}

docker push us-west1-docker.pkg.dev/integral-zephyr-481413-k6/dev/anime-rest-api:${VERSION}
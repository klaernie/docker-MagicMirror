#!/bin/bash
set -e
set -x

push=""
[[ $1 == "--push" ]] && push=yes

# https://stackoverflow.com/a/51761312/4934537
latest_release=$(git ls-remote --tags --refs --sort="v:refname" https://github.com/MichMich/MagicMirror.git | tail -n1 | sed 's/.*\///')

docker buildx build --progress plain --platform=linux/amd64,linux/arm64,linux/arm/v7 ${push:+"--push"} --build-arg branch="${latest_release}" -t ghcr.io/klaernie/docker-magicmirror:"${latest_release}" -t ghcr.io/klaernie/docker-magicmirror:latest .

#!/usr/bin/env bash
# The gh-pages function optionally takes two arguments
#  - the first argument is the path to the Jekyll site
#  - the second argument is the port number
_src=$(realpath $(dirname $(dirname ${BASH_SOURCE[0]})))
gh-pages(){
  _path=${1:-.}
  _port=${2:-4000}
  docker-compose \
    -f "$_src/docker-compose.yml" \
    -f "$_src/docker-compose.alpine.yml" \
    run --rm \
    -p $_port:4000 \
    -u `id -u`:`id -g` \
    -v `realpath $_path`:/src/site \
    gh-pages
}
gh-pages-inspect(){
  docker inspect $(docker ps -aq) \
  | sed -rn 's/.*IPAddress".*"([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*/\1/p'
}

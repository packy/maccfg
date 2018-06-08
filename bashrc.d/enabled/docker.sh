function docker-bash () {
  if [[ -z "$1" ]]; then
    echo No container specified. Running containers:
    docker ps --format "{{.Names}}"
  else
    docker exec -it $@ bash
  fi
}

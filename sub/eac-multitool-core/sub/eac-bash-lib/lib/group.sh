function group_exist() {
  getent group "$1" > /dev/null
}

function group_id() {
  id --group "$@"
}

function group_name() {
  id --group --name "$@"
}

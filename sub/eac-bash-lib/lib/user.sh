function user_exist() {
  getent passwd "$1" > /dev/null
}

function user_id() {
  id --user "$@"
}

function user_name() {
  id --user --name "$@"
}

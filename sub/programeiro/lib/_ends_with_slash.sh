function _ends_with_slash() {
  case "$1" in
  */)
      echo 'true'
      ;;
  *)
      echo 'false'
      ;;
  esac
}

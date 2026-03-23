function symlink_assert() {
  infom 'Asserting symlink...'
  local LINK_PATH="$1"
  local TARGET_PATH="$2"
  if symlink_exist "$LINK_PATH"; then
    if symlink_target "$LINK_PATH" "$TARGET_PATH"; then
      infom "Symlink \"${LINK_PATH}\" already exist with the right target \"$TARGET_PATH\"."
      return 0
    else
      infom "Symlink \"${LINK_PATH}\" does not point to the target \"$TARGET_PATH\". Removing target..."
      sudo_run rm "$LINK_PATH"
    fi
  elif [ -e "$LINK_PATH" ]; then
    error "A object in the symlink path \"${LINK_PATH}\" already exists, is not a symlink and because of this cannot be removed."
    return 1
  else
    infom "Symlink \"${LINK_PATH}\" does not exist."
  fi
  infom "Creating symlink  \"${LINK_PATH}\" => \"$TARGET_PATH\"..."
  sudo_run mkdir -p "$(dirname "$LINK_PATH")"
  sudo_run ln -s "$TARGET_PATH" "$LINK_PATH"
}
export -f symlink_assert

function symlink_exist() {
  [[ -L "$1" ]]
}
export -f symlink_exist

function symlink_target() {
  local LINK_PATH="$1"
  local TARGET_PATH="$2"

  [ "$(sudo_run readlink "$LINK_PATH")" == "$TARGET_PATH" ]
}
export -f symlink_target

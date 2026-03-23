function systemctl_assert() {
  local STATE_COMMAND="$1"
  local RUN_COMMAND="$2"
  local SERVICE="$3"
  if ! systemctl_is "${STATE_COMMAND}" "${SERVICE}"; then
    systemctl_run "${RUN_COMMAND}" "${SERVICE}"
  fi
}
export -f systemctl_assert

function systemctl_install_multiple() {
  for SERVICE in "$@"; do
    systemctl_install_single "${SERVICE}"
  done
}
export -f systemctl_install_multiple

function systemctl_install_single() {
  local SERVICE="$1"
  systemctl_assert 'enabled' 'enable' "${SERVICE}"
  systemctl_assert 'active' 'start' "${SERVICE}"
}
export -f systemctl_install_single

function systemctl_installed_single() {
  local SERVICE="$1"
  systemctl_is 'enabled' "${SERVICE}" && systemctl_is 'active' "${SERVICE}"
}
export -f systemctl_installed_single

function systemctl_is() {
  local STATE_COMMAND="$1"
  local SERVICE="$2"
  systemctl_run "is-${STATE_COMMAND}" --quiet "${SERVICE}"
}
export -f systemctl_is

function systemctl_run() {
  COMMAND="$1"
  shift
  if sudo_use_r; then
    sudo_run systemctl "${COMMAND}" "$@"
  else
    systemctl "${COMMAND}" --user "$@"
  fi
}
export -f systemctl_run

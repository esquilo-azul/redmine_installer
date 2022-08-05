function ruby_rvm_source() {
  SOURCE_FILE="${HOME}/.rvm/scripts/rvm"
  BIN_DIR="${HOME}/.rvm/bin"
  if [ -f "$SOURCE_FILE" ]; then
    set +u
    export rvm_silence_path_mismatch_check_flag=1
    . "$SOURCE_FILE"
  fi
}

function ruby_rvm_run() {
  ruby_rvm_source
  set +u
  rvm "$@"
}

source "$EACBASHLIB_ROOT/ruby/gem.sh"
source "$EACBASHLIB_ROOT/ruby/rvm.sh"

function ruby_install_multiple() {
  gem install -V "$@"
}
export -f ruby_install_multiple

function ruby_installed_single() {
  gem list --local | grep -io '^[0-9a-z\-]\+' | grep -i "^${1}\$" &> /dev/null
}
export -f ruby_installed_single

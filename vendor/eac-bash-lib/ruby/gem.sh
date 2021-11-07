function ruby_gem_install() {
  for GEM in "$@"; do
    if ! ruby_gem_installed "$GEM"; then
      gem install -V "$GEM"
    fi
  done
}

function ruby_gem_installed() {
  for GEM in "$@"; do
    if ! gem list --local | grep -io '^[0-9a-z\-]\+' | grep -i "^$GEM\$" &> /dev/null; then
      return 1
    fi
  done
}

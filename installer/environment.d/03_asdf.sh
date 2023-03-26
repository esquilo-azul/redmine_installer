export ASDF_PROFILE_PATH='/etc/profile.d/asdf.sh'
if [ -f "$ASDF_PROFILE_PATH" ]; then
  source "$ASDF_PROFILE_PATH"
fi

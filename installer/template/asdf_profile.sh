export ASDF_DIR="%%ASDF_ROOT%%"
export ASDF_DATA_DIR="$ASDF_DIR"
if [ -d "${ASDF_DIR}" ]; then
  source "${ASDF_DIR}/asdf.sh"
fi

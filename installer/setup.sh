for FILE in "${INSTALL_ROOT}/setup.d/"*.sh; do
  source "$FILE"
done

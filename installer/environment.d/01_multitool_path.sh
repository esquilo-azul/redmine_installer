export MULTITOOL_PATH=''
export PROGRAMEIRO_PATH=''
export TASKEIRO_PATH=''

for MULTITOOL_NODE in "${REDMINE_ROOT}/plugins/"*"/installer"; do
  if [ -d "$MULTITOOL_NODE" ]; then
    pathvar_push 'MULTITOOL_PATH' "$MULTITOOL_NODE"
  fi
done

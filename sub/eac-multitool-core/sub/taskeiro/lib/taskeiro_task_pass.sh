function taskeiro_task_pass() {
  if taskeiro_task_call_function "$1" task_condition ; then
    RESULT=0
  else
    RESULT=1
  fi
  taskeiro_task_message_condition "$1" "$RESULT" "$2"
  return $RESULT
}
export -f taskeiro_task_pass

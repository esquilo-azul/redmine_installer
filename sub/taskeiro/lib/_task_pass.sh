function _task_pass() {
  if _call_task_function "$1" task_condition ; then
    RESULT=0
  else
    RESULT=1
  fi
  _task_message_condition "$1" "$RESULT" "$2"
  return $RESULT
}

function _call_task_function {
  local task=$1
  local script=$(taskeiro_task_path "$task")
  local function_name=$2
  local required='0'
  if [ $# -ge 3 ]; then
    required=$3
  fi
  unset -f $function_name
  source "$script"
  if _function_exists "$function_name"; then
    "$function_name"
  elif [ "$required" == '0' ]; then
    fatal_error "Function \"$function_name\" not found for task \"$task\""
  fi
}

function _task_message_condition {
  local result=$2
  local after=$3
  local m=''
  if [ "$2" == '0' ]; then
    m=$m"${FG_LGREEN}ok${NC}"
  else
    m=$m"${FG_LRED}not ok${NC}"
  fi
  if [ "$3" == '0' ]; then
    m=$m' (AFTER FIX)'
  fi
  m=$m" $FG_LYELLOW[$(taskeiro_task_dependencies "$1")]$NC"
  infov "$1" "$m"
}

function _p_find_program_in_path {
  local prgname=$1
  local path=$2
  local prgpath="$path""$prgname"
  local prgbasename="$(basename "$prgpath")"

  find "$path" -path "$prgpath*" | while read line; do
    filename=$(basename "$line")
    filename="${filename%.*}"
    if [ "$filename" == "$prgbasename" ]; then
      echo "$line"
      return
    fi
  done

  return $PROGRAMEIRO_NOT_FOUND_ERROR
}

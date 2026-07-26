function programeiro_completion_search_in_node() {
  local root_dir=$1
  local subdir=$2
  local subpath=$(echo $3 | sed 's|^/\+||g' | sed 's|/\+$||g')
  local ends_with_slash=$4
  subpath_fn=$(echo "$subpath" | sed 's|/.*$||g')
  subpath_left=$(echo "$subpath" | sed 's|^[^/]*/||g')
  if [ "$subpath_left" == "$subpath" ]; then
    subpath_left=''
  fi
  local find_pattern
  if [ -n "$subpath_left" ]; then
    find_pattern="$subpath_fn"
  else
    find_pattern="$subpath_fn*"
  fi
  find "$root_dir/$subdir" -mindepth 1 -maxdepth 1 -name "$find_pattern" | while read line; do
    item=$(basename "$line")
    if [ -z "$subpath_left" ]; then
      if [ "$ends_with_slash" == 'true' ] && [ -n "$subpath" ]; then
        if [ "$item" == "$subpath_fn" ] && [ -d "$line" ]; then
          programeiro_completion_search_in_node "$root_dir" "$subdir/$item" '' "$ends_with_slash"
        fi
      elif [ -d "$line" ]; then
        echo "$subdir/$item/"
      else
        echo "$subdir/${item%.*}"
      fi
    elif [ -d "$line" ]; then
      programeiro_completion_search_in_node "$root_dir" "$subdir/$item" "$subpath_left" "$ends_with_slash"
    fi
  done
}

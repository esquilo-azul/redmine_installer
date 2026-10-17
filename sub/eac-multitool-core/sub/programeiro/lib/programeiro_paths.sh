function programeiro_paths {
  pathvar_assert 'PROGRAMEIRO_PATH'
  var_set_by THE_PROGRAMEIRO_PATH pathvar_join "${PROGRAMEIRO_PATH}" "$PROGRAMEIRO_ROOT/programs"
  pathvar_to_lines 'THE_PROGRAMEIRO_PATH'
}

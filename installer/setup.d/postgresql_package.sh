export POSTGRESQL_DEFAULT_PACKAGE='postgresql'
if var_blank_r 'postgresql_version'; then
  export postgresql_version="$(programeiro /postgresql/default_version)"
fi
export POSTGRESQL_PACKAGE="${POSTGRESQL_DEFAULT_PACKAGE}-${postgresql_version}"

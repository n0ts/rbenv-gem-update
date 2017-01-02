if declare -Ff after_install >/dev/null; then
  after_install gem_update_system
else
  echo "rbenv: rbenv-gem-update plugin requires ruby-build 20130129 or later" >&2
fi

verlte() {
  [ "$1" = "$2" ] && return 1 || [  "$2" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

gem_update_system() {
  # Exit if Ruby wasn't installed successfully
  [ "$STATUS" = "0" ] || return 0

  # Only CRuby
  [[ "$VERSION_NAME" != 2.* ]] && return 0

  # CRuby version 2.4.0 or later
  # Invoke `gem update --system` in the just-installed Ruby.
  verlte $VERSION_NAME 2.4 && RBENV_VERSION="$VERSION_NAME" rbenv-exec gem update --system
}

#! bash
unshift_path $HOMEBREW_PREFIX/lib/ruby/gems/2.7.0/bin
unshift_path $HOMEBREW_PREFIX/lib/ruby/gems/2.6.0/bin
unshift_path $HOMEBREW_PREFIX/opt/ruby/bin

# find any gems that have tab completion defined
TAB_COMPLETE=$(find $HOMEBREW_PREFIX/lib/ruby/gems -name tab_complete.sh 2>/dev/null)
[[ ! -z "$TAB_COMPLETE" ]] && source  $TAB_COMPLETE

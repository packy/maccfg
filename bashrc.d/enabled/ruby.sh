#! bash
unshift_path /usr/local/lib/ruby/gems/2.7.0/bin
unshift_path /usr/local/lib/ruby/gems/2.6.0/bin
unshift_path /usr/local/opt/ruby/bin

# find any gems that have tab completion defined
source $(find /usr/local/lib/ruby/gems -name tab_complete.sh)

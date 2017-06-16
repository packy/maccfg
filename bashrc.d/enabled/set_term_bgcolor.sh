#!bash # for emacs formatting

function set_term_bgcolor () {
    perl -e '
my $color = shift @ARGV;
my($r,$g,$b) = $color =~ /(..)(..)(..)/;
($r,$g,$b) = ( hex($r) * 65535/255, hex($g) * 65535/255, hex($b) * 65535/255 );
print qq(tell application "iTerm2"
  tell current session of current window
    set background color to {$r,$g,$b} # color $color
  end tell
end tell
)
' "$@" | osascript
}

#!bash # for emacs formatting

alias  p='(cd $HOME/git/AIM/pronimbus; util/sync.sh packy --version commit)'
alias pk='(cd $HOME/git/AIM/komatik/base; util/sync.sh packy --version commit)'

alias reports='pstorm htdocs/module/CMF/view/cmf/reporting/index.phtml htdocs/assets/js/custom/reports.js htdocs/module/CMF/src/CMF/Controller/ReportingController.php htdocs/module/CMF/src/CMF/Model/Reporting.php htdocs/module/OMS/src/OMS/Model/AsyncReports.php'

function ringcentral () {
  open zoomrc://ringcentral.zoom.us/join?action=join\&confno=$1
}
alias standup="ringcentral 1459746854"

function epoch_to_timestamp () {
    perl -M5.010 -MPOSIX -e '
my $file = shift @ARGV;
my ($epoch) = $file =~ /(\d{10})/;
say POSIX::strftime(q{%Y-%m-%d_%H-%M-%S}, localtime($epoch));
' $*
}

function to_base () {
  [[ -z "$SCP_TO_NETSVC" ]] && export SCP_TO_NETSVC=1
  BASE=$1; shift
  for FILE in "$@"; do
    DIR=$(dirname $FILE)
    scp $FILE net-svc-$SCP_TO_NETSVC:$BASE/$DIR
    export SCP_TO_NETSVC=$(( (($SCP_TO_NETSVC + 1) % 3) +1 )) # 1 3 2
  done
}

function to_dev () {
  BASE=$1; shift
  for FILE in "$@"; do
    DIR=$(dirname $FILE)
    scp $FILE net-svc-5:$BASE/$DIR
  done
}

function to_kom () {
  BASE=$1; shift
  for FILE in "$@"; do
    DIR=$(dirname $FILE)
    scp $FILE net-svc-b:$BASE/$DIR
  done
}
alias to_kom_qat='to_kom /code/oms/qat/current'
alias to_kom_uat='to_kom /code/oms/uat/current'
alias to_kom_fdl='to_kom /code/oms/fdl/current'
alias to_kom_om1='to_kom /code/oms/om1/current'

re_source_file $HOME/.bash_aim # work files

# function to indent the contents of the paste buffer N spaces
pbindent () {
  pbpaste | INDENT=$1 perl -pe 's/^/" "x$ENV{INDENT}/e' | pbcopy
}

pbrelease () {
  pbpaste | jira-release-notes-to-md | pbcopy
}

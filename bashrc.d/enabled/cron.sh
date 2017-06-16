#!bash  # for emacs highlighting

# my usual crontab comment
cron_header () {
    echo "# min hr day mon     dow       command"
    echo "# --- -- --- --- -----------  --------------------------------------------------"
}

# an alternate crontab comment I've played with
cron_footer () {
echo "
# ^ ^ ^ ^ ^           ^- command to execute
# │ │ │ │ └─ day of week (0 - 6) (0 to 6 are Sunday to Saturday)
# │ │ │ └─── month (1 - 12)
# │ │ └───── day of month (1 - 31)
# │ └─────── hour (0 - 23)
# └───────── min (0 - 59)"
}

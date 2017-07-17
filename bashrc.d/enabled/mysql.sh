#!bash

function mysqlg () {
  mysql --defaults-group-suffix=$1
}

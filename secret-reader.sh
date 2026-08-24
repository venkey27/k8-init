#!/bin/bash

# 1. check whether /secrets/mysql-secret.txt exist
# 2. if exist export and remove
# 3. if not exist throw the error

if [ -f /secrets/mysql-secret.txt ]; then
    ROOT_PASSWORD=$(cat /secrets/mysql-secret.txt)  #  ROOT_PASSWORD contains paswword
    echo "Password accessed successfully"
else
    echo "cant find the password"                   # if error occur, password didnt acessed
    exit 1
fi

export MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD
rm /secrets/mysql-secret.txt

exec /usr/local/bin/docker-entrypoint.sh mysqld  # this is mysql entry point, after complection of mqsql-secret.txt mysql will execute

# Standard Linux Convention: In Linux and Unix-like environments, /usr/local/bin/ is the standard directory designated for custom,  
# user-supplied, or third-party executable scripts and binaries.

# By placing secret-reader.sh in the same directory (/usr/local/bin/), you keep all your custom entrypoint logic organized alongside 
# the container's standard binaries and ensure it has direct access to invoke /usr/local/bin/docker-entrypoint.sh.
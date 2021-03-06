#!/bin/sh

set -e
set -x

#pp default: is ENV_NAME="puma_production", USER=ubuntu, ROOT=/var/www/rails/sflxActive
#p usage: -u username -e environment_full_name -s (mac or ubuntu)

# Simple move this file into your Rails `script` folder. Also make sure you `chmod +x puma.sh`.
# Please modify the CONSTANT variables to fit your configurations.

# The script will start with config set by $PUMA_CONFIG_FILE by default

while [[ $# -gt 1 ]]
do
    key="$1"
    case $key in
	-u|--user)
	    USER="$2"
	    shift
	    ;;
	-e|--environment)
	    ENV="$2"
	    shift
	    ;;
	-s|--system)
	    SYS="$2"
	    shift
	    ;;
	*)
	    ;;
    esac
    shift
done

# default for production and prevent wrong type
# if [ -z "$ENV" ]; then
#     ENV_NAME="puma_production"
#     USER=ubuntu
# else
#     ENV_NAME=puma_"$ENV"
# fi

case $ENV in
    development)
	ENV_NAME=puma_$ENV
	;;
    *)
	ENV_NAME=puma_production
	;;
esac

case $USER in
    leeli)
    ;;
    *)
	USER=ubuntu
	 ;;
esac

case $SYS in
    mac)
	ROOT=/Users/$USER/www/rails/sflxActive
	USER_DIR=Users
	;;
    *)
	ROOT=/home/$USER/www/rails/sflxActive
	USER_DIR=home
	;;
esac


PUMA_CONFIG_FILE=$ROOT/config/$ENV_NAME.rb
PUMA_PID_FILE=/tmp/$ENV_NAME.pid
PUMA_SOCKET=/tmp/$ENV_NAME.sock


# check if puma process is running
puma_is_running() {
    if [ -S $PUMA_SOCKET ] ; then
	if [ -e $PUMA_PID_FILE ] ; then
	    if cat $PUMA_PID_FILE | xargs pgrep -P > /dev/null ; then
		return 0
	    else
		echo "No puma process found"
	    fi
	else
	    echo "No puma pid file found"
	fi
    else
	echo "No puma socket found"
    fi

    return 1
}

case "$1" in
    start)
	echo "Starting puma..."
	rm -f $PUMA_SOCKET
	if [ -e $PUMA_CONFIG_FILE ] ; then
	    su $USER -c  "source /$USER_DIR/$USER/.zshrc; cd $ROOT && bundle exec puma --config $PUMA_CONFIG_FILE"
	    # else
	    
	    # bundle exec puma --daemon --bind unix://$PUMA_SOCKET --pidfile $PUMA_PID_FILE
	fi

	echo "done"
	;;

    stop)
	echo "Stopping puma..."
	kill -s SIGTERM `cat $PUMA_PID_FILE`
	rm -f $PUMA_PID_FILE
	rm -f $PUMA_SOCKET

	echo "done"
	;;

    restart)
	if puma_is_running ; then
	    echo "Hot-restarting puma..."
	    kill -s SIGUSR2 `cat $PUMA_PID_FILE`

	    echo "Doublechecking the process restart..."
	    sleep 5
	    if puma_is_running ; then
		echo "done"
		exit 0
	    else
		echo "Puma restart failed :/"
	    fi
	fi

	echo "Trying cold reboot"
	script/puma.sh start
	;;

    *)
	echo "Usage: script/puma.sh -u user {start|stop|restart}" >&2
	;;
esac

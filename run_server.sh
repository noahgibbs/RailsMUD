#!/bin/bash

# This script runs the MUD server, including auxiliary services like
# Juggernaut.  Rails has many fine deployment methods.  This gives only
# the most basic.

if [ -r private_variables.sh ]
then
  . private_variables.sh
else
  echo You have not created private_variables.sh!  Read INSTALL for details.
  exit
fi

juggernaut -c juggernaut.yml &
./script/server -p $RM_SITE_PORT -e $RM_RAILS_ENVIRONMENT

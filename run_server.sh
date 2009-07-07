#!/bin/bash

# This script runs the MUD server, including auxiliary services like
# Juggernaut.  Rails has many fine deployment methods.  This gives only
# the most basic, where you run everything on a single server together.

if [ -r private_variables.sh ]
then
  . private_variables.sh
else
  echo You have not created private_variables.sh!  Read INSTALL for details.
  exit
fi

# Juggernaut server for pushing chat, text and certain AJAX data
# $RM_JUGGERNAUT_HOST must be this machine if you don't change this
juggernaut -c juggernaut.yml &

# MUD server for coordinating the environment
# $RM_GAMESERVER_HOST must be this machine if you don't change this
./game/server -p $RM_GAMESERVER_PORT

# Rails server for player UI and the web site
./script/server -p $RM_SITE_PORT -e $RM_RAILS_ENVIRONMENT

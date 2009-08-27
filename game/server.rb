#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

RAILS_GEM_VERSION = (ENV['RM_RAILS_GEM_VERSION'] || '2.3.3') unless defined? RAILS_GEM_VERSION

require File.dirname(__FILE__) + "/../config/environment"

gem "railsgame"
require "railsgame"

RailsConfigDir = File.expand_path(File.join(File.dirname(__FILE__),
					    "..", "config"))
RailsModelsDir = File.expand_path(File.join(File.dirname(__FILE__), "..",
					    "app", "models"))

JuggernautHosts = File.join(RailsConfigDir, "juggernaut_hosts.yml")
$LOAD_PATH << RailsModelsDir

# ActiveRecord models for game objects
require "basic_object"
require "basic_room"
require "basic_mobile"

# Game objects that don't touch Rails directly
require "start_location"
require "player"
require "actions"

# Actually create the server
server = RailsMUDServer.new
server.jug_hosts_file(JuggernautHosts)
server.connect

# Just prints whether connection was successful
if server.connected?
  print "GameServer: Connected!\n"
else
  print "GameServer: Not Connected!\n"
end

server.loop_while_connected

print "GameServer: exited\n"

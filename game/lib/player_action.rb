gem "actionpack"
require "action_view/erb/util"

require 'command_parser.rb'
require 'player.rb'

module PlayerAction
  JC = JuggernautConnect

  class << self
    include ERB::Util
  end

  def self.received(player, verb, objects)
    verb, objects = CommandParser.process(player, objects) if verb == 'parse'
    objects = [objects] unless objects.kind_of? Array

    print "PlayerAction: #{verb} on [#{objects.join(" / ")}]\n"

    if verb == 'think'
      Player.send_to_players("You think to yourself, \"#{h objects.join(' ')}\". <br />",
                             [player])
    end
  end
end

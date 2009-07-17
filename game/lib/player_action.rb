require 'command_parser.rb'

module PlayerAction
  def self.received(verb, objects)
    verb, objects = CommandParser.process(objects) if verb == 'parse'

    print "PlayerAction: #{verb} on [#{objects.join(" / ")}]\n"
  end
end

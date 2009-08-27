# Basic 'void' room, guaranteed to exist.  It can't be linked to ActiveRecord
# rooms via exits, nor can they be linked to it.
class StartLocation
  include RailsGame::Location
  include Singleton

  def show_to(player)
    "This is the starting room.  You can't do anything interesting here. <br/>\n" +
    "EXITS: (none)<br/>\n"
  end
end

# Instantiate it
StartLocation.instance()

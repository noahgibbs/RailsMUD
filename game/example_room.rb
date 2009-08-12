gem "railsgame"

require "railsgame"

class StartRoom
  include RailsGame::Location
  include Singleton

  def show_to(player)
    "This is the starting room.  You can't do anything interesting here. <br/>"
  end
end

# Instantiate it
StartRoom.instance()

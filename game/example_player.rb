gem "railsgame"
require "railsgame"

require "example_room.rb"

class ExamplePlayer < RailsGame::Player
  playerClass

  def self.login(name, objects)
    super(name, objects)
    player = RailsGame::Player.by_name(name)
    player.send_html("Welcome to #{ENV['RM_SITE_NAME']}, #{name}! <br />")

    player.move_to(StartRoom.instance())
    player.show_current_location
  end

  def self.logout(name, objects)
    player.move_to(nil)
    super(name, objects)
  end

end

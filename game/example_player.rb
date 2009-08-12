gem "railsgame"
require "railsgame"

class ExamplePlayer < RailsGame::Player
  playerClass

  def self.login(name, objects)
    super(name, objects)
    player = RailsGame::Player.by_name(name)
    player.send_html("Welcome to #{ENV['RM_SITE_NAME']}, #{name}! <br />")
  end

  def self.logout(name, objects)
    super(name, objects)
  end

end

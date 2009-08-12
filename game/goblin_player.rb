gem "railsgame"
require "railsgame"

class GoblinPlayer < RailsGame::Player
  playerClass

  def self.login(name, objects)
    super(name, objects)
    player = RailsGame::Player.by_name(name)
    player.send_html("Welcome to GoblinMUD, #{name}! <br />")
  end

  def self.logout(name, objects)
    super(name, objects)
  end

end

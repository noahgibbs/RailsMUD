gem "railsgame"
require "railsgame"

class GoblinPlayer < RailsGame::Player
  playerClass

  def self.login(name, objects)
    super(name, objects)
    player = RailsGame::Player.get_player_by_name(name)
    RailsGame::Player.send_to_players("Welcome to GoblinMUD, #{name}! <br />", name);
  end

  def self.logout(name, objects)
    super(name, objects)
  end

end

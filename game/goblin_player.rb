require File.dirname(__FILE__) + "/lib/player.rb"

class GoblinPlayer < Player
  playerClass

  def self.login(name, objects)
    super(name, objects)
    player = Player.get_player_by_name(name)
    Player.send_to_players("Welcome to GoblinMUD, #{name}! <br />", name);
  end

  def self.logout(name, objects)
    super(name, objects)
  end

end

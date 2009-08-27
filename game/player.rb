gem "railsgame"
require "railsgame"

gem "activerecord"
require "activerecord"

require "start_location.rb"

class BasicPlayer < BasicMobile
  include RailsGame::Player  # This sets BasicPlayer as the active Player class

  def self.login(name, objects)
    RailsGame::Player.login(name, objects)
    player = RailsGame::Player.by_name(name)
    player.send_html("Welcome to #{ENV['RM_SITE_NAME']}, #{name}! <br />")

    player.move_to(StartRoom.instance())
    player.show_current_location
  end

  def self.logout(name, objects)
    player.move_to(nil)
    RailsGame::Player.logout(name, objects)
  end

end

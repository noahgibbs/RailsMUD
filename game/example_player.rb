gem "railsgame"
require "railsgame"

gem "activerecord"
require "activerecord"

require "example_room.rb"

class BasicPlayer < BasicMobile
  include RailsGame::Player  # This sets BasicPlayer as the active Player class
  @@ar_init = false

  def self.activerecord_init
    unless @@ar_init
      db_conf_file = File.join(RailsConfigDir, "database.yml")
      config = YAML::load(ERB.new(IO.read(db_conf_file)).result)
      ActiveRecord::Base.configurations = config
      ActiveRecord::Base.establish_connection(config[ENV['RM_RAILS_ENVIRONMENT']])
      @@ar_init = true
    end
  end

  def self.login(name, objects)
    # Establish ActiveRecord connection
    self.activerecord_init unless @@ar_init

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

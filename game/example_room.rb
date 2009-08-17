gem "railsgame"
require "railsgame"

gem "activerecord"
require "activerecord"

require "example_object"

class BasicRoom < BasicObject
  # This has_many is used for exits
  has_many :basic_exits

  def exits_string
    es = (self.basic_exits.map { |e| e.name }).join(" ")
    es.empty? ? "(none)" : es
  end

  def show_to(player)
    self.name + "<br/>\n" +
    self.base_description + "<br/>\n" +
    "EXITS: " + exits_string
  end

end

class BasicExit < ActiveRecord::Base
  belongs_to :basic_object
  serialize :tags, Hash
end

# Basic 'void' room, guaranteed to exist
class StartRoom
  include RailsGame::Location
  include Singleton

  def show_to(player)
    "This is the starting room.  You can't do anything interesting here. <br/>\n" +
    "EXITS: (none)<br/>\n"
  end
end

# Instantiate it
StartRoom.instance()

gem "actionpack"
require "action_view"
require "action_view/erb/util"
require "juggernaut_connect.rb"

class Player
  attr :login
  @@players = []

  class << self
    include ActionView::Helpers::JavaScriptHelper # for javascript_escape
    include ERB::Util  # for html_escape aka h
  end

  def initialize(login)
    @login = login
  end

  def self.login(name, objects)
    p = Player.new(name)
    @@players[name] = p
  end

  def self.logout(name, objects)
    @@players[name] = nil
  end

  def self.send_to_players(text, players)
    players = [players] unless players.kind_of? Array

    str = "try {\nadd_world_output(\"#{escape_javascript(text)}\");\n} catch (e) { alert('GS error:\\n\\n' + e.toString()); alert('add_world_output(\\\"\#{text}\\\");'); throw e }"
    JuggernautConnect.send_to_clients(str, self.get_names_from_objs(players))
  end

  private

  def self.get_names_from_objs(players)
    players.map { |p|
      p.kind_of?(String) ? p : p.login
    }
  end

end

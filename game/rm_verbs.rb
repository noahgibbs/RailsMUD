gem "actionpack"
require "action_view/erb/util"

class RailsMUDServer < RailsGame::Server
  include ERB::Util  # for HTML escaping

  def action_think(player, objects)
    player.send_html("You think '#{h objects}'. <br />")
  end

  def unknown_action(player, verb, objects)
    player.send_html("I don't know the verb '#{h verb}'.  Sorry! <br />")
  end
end

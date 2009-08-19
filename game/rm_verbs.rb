gem "actionpack"
require "action_view/erb/util"

class RailsMUDServer < RailsGame::Server
  include ERB::Util  # for HTML escaping

  def action_think(player, objects)
    player.send_html("You think '#{h objects}'. <br />")
  end

  def action_say(player, objects)
    if player.location
      player.location.show_text("#{player.name} says, '#{h objects}'. <br />")
    else
      player.send_html "You aren't anywhere, so your words are lost. <br/>"
    end
  end

  def action_look(player, objects)
    if objects.empty?
      player.show_current_location
      return
    end

    player.send_html("Not implemented yet. <br />")
  end

  def action_list_objects(player, objects)
    unless objects.empty?
      player.send_html("list_objects takes no parameters. <br />")
      return
    end

    objs = BasicObject.find :all
    if objs.empty?
      player.send_html("There are no database-backed objects currently. <br/>")
      return
    end

    objs_list = objs.map {|r| r.name}.join("</li> <li>")
    objs_list = "<ul> <li>#{objs_list}</li> </ul>"

    player.send_html "All objects:<br/>#{objs_list}<br/>"
  end

  def unknown_action(player, verb, objects)
    player.send_html("I don't know the verb '#{h verb}'.  Sorry! <br />")
  end
end

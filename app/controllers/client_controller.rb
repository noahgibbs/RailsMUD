class ClientController < ApplicationController
  include AuthenticatedSystem

  before_filter :login_required, :only => [ 'full' ]

  def home
  end

  def full
  end

  # Juggernaut subscription URL
  def jug_login
    #if(session[:user_id] != params[:client_id])
    #  render :nothing => true, :status => 502
    #  return
    #end

    hash = { :client => params[:client_id], :type => :action,
             :verb => 'login', :objects => "" }
    Juggernaut.send_to_client(hash.to_json, "gameserver")
    render :nothing => true
  end

  def jug_logout
    hash = { :client => params[:client_id], :type => :action,
             :verb => 'logout', :objects => "" }
    Juggernaut.send_to_client(hash.to_json, "gameserver")
    render :nothing => true
  end

  # We don't normally care about this, and it shouldn't normally happen
  def jug_con_logout
    render :nothing => true
  end

  # Is this handled already by jug_login on connection?
  def jug_broadcast
    render :nothing => true
  end

  def send_chat_data
    render :juggernaut => { :type => :send_to_channel,
                            :channel => "chat" } do |p|
      #p.insert_html :top, 'chat_data', "<li>#{h params[:chat_input]}</li>"
      p << "add_chat(\"#{current_user.login}\", " +
        "\"#{escape_javascript h params[:chat_input]}\");"
    end
    render :nothing => true
  end

  def send_action_text
    hash = { :client => current_user.login, :type => :action,
             :verb => 'parse', :objects => params[:action_text] }
    Juggernaut.send_to_channels(hash.to_json, "action")

    render :nothing => true
  end

end

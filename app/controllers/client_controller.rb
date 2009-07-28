require File.dirname(__FILE__) + "/../../game/jugger_keys.rb"

class ClientController < ApplicationController
  include AuthenticatedSystem
  include JuggernautConnect      # To get shared secret keys

  before_filter :login_required, :only => [ 'full' ]

  def home
  end

  def full
    @jcookie = cookies[ActionController::Base.session_options[:key]]
  end

  # Juggernaut subscription URL
  def jug_login
    if params[:client_id] == "gameserver"
      if params[:session_id] != GS_login_session_id
        # That's not the shared secret we wanted.  Fail!
        render :nothing => true, :status => 501
        return
      end
      render :text => "dummy"
      return
    end

    if(current_user.login != params[:client_id])
      render :nothing => true, :status => 502
      return
    end
    hash = { :client => params[:client_id], :type => :action,
             :verb => 'login',
             :objects => [ :remote_ip => request.remote_ip ] }
    Juggernaut.send_to_client(hash.to_json, "gameserver")

    # Juggernaut seems to sometimes need some text sent or it will take even
    # a status of 200 as failure when it hits EOF.
    render :text => "dummy"
  end

  def jug_logout
    hash = { :client => params[:client_id], :type => :action,
             :verb => 'logout', :objects => "" }
    Juggernaut.send_to_client(hash.to_json, "gameserver")
    render :text => "dummy"
  end

  # We don't normally care about this, and it shouldn't normally happen
  def jug_con_logout
    render :nothing => true
  end

  def jug_broadcast
    # Protect broadcasts from gameserver
    if params[:client_id] == "gameserver"
      if params[:session_id] != GS_login_session_id
        render :nothing => true, :status => 501
        return
      end
      render :text => "dummy"
      return
    end

    render :nothing => true, :status => 501
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

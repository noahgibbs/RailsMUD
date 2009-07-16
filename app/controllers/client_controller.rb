class ClientController < ApplicationController
  include AuthenticatedSystem

  before_filter :login_required, :only => [ 'full' ]

  def home
  end

  def full
  end

  def send_chat_data
    render :juggernaut => { :type => :send_to_channel,
                            :channel => "chat" } do |p|
      #p.insert_html :top, 'chat_data', "<li>#{h params[:chat_input]}</li>"
      p << "do_chat(\"#{current_user.login}\", " +
        "\"#{escape_javascript h params[:chat_input]}\");"
    end
    render :nothing => true
  end

  def send_action_data
    render :juggernaut => { :type => :send_to_channel,
                            :channel => "action" } do |p|
      hash = { :client => current_user.login, :type => :action,
               :verb => params[:verb], :objects => params[:objects] }
      p << hash.to_json
    end
    render :nothing => true
  end

end

class ClientController < ApplicationController
  include AuthenticatedSystem

  before_filter :login_required, :only => [ 'full' ]

  def home
  end

  def full
  end

  def send_chat_data
    render :juggernaut, :type => :send_to_channel,
             :channel => [:chat] do |page|
      #page.insert_html :top, 'chat_data', "<li>#{h params[:chat_input]}</li>"
      page << "do_chat(\"#{escape_javascript h params[:chat_input]}\");"
    end
    render :nothing => true
  end

end

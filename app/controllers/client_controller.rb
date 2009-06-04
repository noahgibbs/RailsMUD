class ClientController < ApplicationController
  include AuthenticatedSystem

  before_filter :login_required, :only => [ 'full' ]

  def home
  end

  def full
  end

  def send_chat_data
    render :juggernaut do |page|
      page.insert_html :top, 'chat_data', "<li>#{h params[:chat_input]}</li>"
    end
    render :nothing => true
  end

end

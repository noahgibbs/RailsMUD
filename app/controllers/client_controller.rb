class ClientController < ApplicationController
  include AuthenticatedSystem

  before_filter :requires_login, :only => 'full'

  def home
    # Can't use this func as a before filter -- current_user wouldn't exist
    # because the restful_authentication before filters haven't been run yet.
    login_cookie
  end

  def full
  end

  def send_chat_data
    render :juggernaut do |page|
      page.insert_html :top, 'chat_data', "<li>#{h params[:chat_input]}</li>"
    end
    render :nothing => true
  end

  private

  def requires_login
    logged_in?
  end

  def login_cookie
    if current_user
      request.cookies['login'] = cookies['login'] = current_user.login
    else
      cookies['login'] = nil
    end
    true
  end

end

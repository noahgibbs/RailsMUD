class ClientController < ApplicationController
  include AuthenticatedSystem

  def home
    login_cookie  # Can't use as a before filter -- current_user wouldn't exist
  end

  private

  def login_cookie
    if current_user
      request.cookies['login'] = cookies['login'] = current_user.login
    else
      cookies['login'] = nil
    end
    true
  end

end

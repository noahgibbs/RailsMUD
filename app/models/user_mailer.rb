class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'

    @body[:url]  = ENV['RM_SITE_URL'] + "/activate/#{user.activation_code}"

  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = ENV['RM_SITE_URL']
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = ENV['RM_ADMIN_EMAIL']
      @subject     = ENV['RM_MAIL_PREFIX'] + " "
      @sent_on     = Time.now
      @body[:user] = user
    end
end

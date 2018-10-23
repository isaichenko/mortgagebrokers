class BrokerMailer < ApplicationMailer
  #sending a notification email for broker whose account is in process
  def send_verification_process_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Account Verification Status - In process')
  end  
end

class InvitationMailer < ApplicationMailer
  def send_invitation_notification(emails,borrower_request)
    @email = emails
    @borrower_request = borrower_request
    mail(to: @email, subject: 'You have invited for bidding a borrower request')
  end 
  def cancel_invitation_notification(broker,borrower_request)
    @user = broker
    @borrower_request = borrower_request
    mail(to: @user.email, subject: 'Your invitation for bidding a borrower request has been cancelled')
  end        
end

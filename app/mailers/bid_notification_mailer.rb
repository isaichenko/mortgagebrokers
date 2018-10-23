class BidNotificationMailer < ApplicationMailer
  def send_bid_notification(bid)
    @user = bid.user
    mail(to: @user.email, subject: 'You have a new bid')
  end 

  def send_bid_accept_notification(proposal)
    @user = proposal.user
    mail(to: @user.email, subject: 'Your bid has been Accepted')
  end  

  def send_bid_reject_notification(proposal)
    @user = proposal.user
    mail(to: @user.email, subject: 'Your bid has been Rejected')
  end      
end

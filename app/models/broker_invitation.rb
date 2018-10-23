class BrokerInvitation < ApplicationRecord
  belongs_to :borrower_request , optional: true
  belongs_to :user , optional: true
  def self.create_broker_invitation brokers , borrower_request
    brokers.each do |broker|
      BrokerInvitation.create(borrower_request_id: borrower_request.id , user_id: broker.id , invitation_sent_at: Time.now)
    end     
  end 
end

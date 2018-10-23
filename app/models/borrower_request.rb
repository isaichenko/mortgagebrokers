class BorrowerRequest < ApplicationRecord
  paginates_per 4
  serialize :place, Array
  default_scope -> { order(created_at: :desc) }
  belongs_to :user , optional: true
  has_many :broker_invitations
  has_many :bids
  validates_presence_of :mortgage_type , :property_address,:credit_score,:mortagage_level,:description
  validates :property_value, numericality: { greater_than_or_equal_to: 50000 }, presence: true
  validates_length_of :description, :maximum => 2000


  def draft
    return true if self.status == REQ_STATUS[:draft]
  end  
  def expired
    return true if self.status == REQ_STATUS[:expire]
  end  
  def publish
    return true if (self.status == REQ_STATUS[:publish] && (self.bids.where("status = ?", BID_STATUS[:approved]).size == 0))
  end 

  def approved
    return true if (self.status == REQ_STATUS[:publish] && (self.bids.where(status: BID_STATUS[:approved]).size == 1))
  end 

  def can_cancel
    return true if (self.status == REQ_STATUS[:publish] && (self.bids.size == 0)) 
  end 
  def approved_bid_id
    return self.bids.where(status: BID_STATUS[:approved]).first.id 
  end 
  def self.get_my_deals broker_invitations
  	#return self.where("status = ? AND bidding_end_time > ? AND id in (?) ", REQ_STATUS[:publish] , Time.now , broker_invitations.pluck(:borrower_request_id))
    return self.where("id in (?) ", broker_invitations.pluck(:borrower_request_id))
  end 
  def self.get_requests_count user 
  	@borrower_requests = user.borrower_requests  
    counts_hash = {}
    [:expired,:published,:draft,:cancelled].each do |obj|
       counts_hash[obj] = @borrower_requests.where(status: obj.to_s).size
    end 
    return counts_hash.merge(all: @borrower_requests.size)
  end 
  def self.get_deals_count deals , user 
    counts_hash = {}
    [:approved, :rejected,:sent].each do |obj|
      counts_hash[obj] = deals.select{ |d|  d.bids.any? {|h| h.status== obj.to_s.capitalize && h.user_id ==  user.id } }.size
    end 
    return counts_hash.merge(invited: deals.select{ |d|  !d.bids.any? }.size, all: deals.size)
  end   

  def self.publish_borrower_request borrower_request
    @brokers = User.borrower_request_brokers(borrower_request)    
    BrokerInvitation.create_broker_invitation @brokers , borrower_request
    borrower_request.update_attributes(status: REQ_STATUS[:publish] ,bidding_end_time: Time.now+3.days,published_at: Time.now)
    @brokers.pluck(:email).each do |email| 
      InvitationMailer.send_invitation_notification(email,borrower_request).deliver_now
    end 
  end 
  def self.cancel_borrower_request borrower_request
    @brokers = User.where("id in (?)",borrower_request.broker_invitations.pluck(:id))
    borrower_request.update_attributes(status: REQ_STATUS[:cancelled])
    @brokers.each do |broker| 
      InvitationMailer.cancel_invitation_notification(broker,borrower_request).deliver_now
    end    
  end
  def self.handle_expired_borrower_requests
    requests = BorrowerRequest.where("bidding_end_time < ?",Time.now).includes(:bids)
    requests.each do |b|
      !b.bids.any? ? b.update_attributes(status: REQ_STATUS[:expire]) : (b.update_attributes(status: REQ_STATUS[:expire]) if !b.bids{|h|  h.status.includes?([BID_STATUS[:approved],BID_STATUS[:rejected],BID_STATUS[:sent]])}.any?)
    end 
  end

end

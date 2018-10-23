class Bid < ApplicationRecord

  validates :mortgage_type , :term,:pre_payment_penalties,:comments,presence: true
  validates :rate, numericality: { greater_than: 0 ,less_than_or_equal_to: BID_MAX_RATE}, presence: true
  validates :broker_fee, numericality: { greater_than: 0 ,less_than_or_equal_to: BID_MAX_BROKER_FEE}, presence: true
  validates :lender_fee, numericality: { greater_than: 0 ,less_than_or_equal_to: BID_MAX_LENDER_FEE}, presence: true
  validates :amortization, numericality: { greater_than_or_equal_to: 0 ,less_than_or_equal_to: BID_MAX_AMORTIZATION}, presence: true
  validates_length_of :comments, minimum: 100  , maximum: 2000
  belongs_to :borrower_request , optional: true
  belongs_to :user , optional: true

  def self.check_deal_exists deal , user 
    @bid = Bid.where(borrower_request_id: deal.id, user_id: user.id).first
    @bid.present? ? self.get_bid_status_text(@bid.status) : self.get_bid_status_text(nil)
  end 

  def self.check_bids_for_user deal , user 
    bids = deal.bids    
    if bids
      user_bid = bids.where(user_id: user.id)
      user_bid.present? ? (self.bid_status user_bid.first.status) : (return BID_STATUS[:invited])
    else
      return "no bids"
    end 
  end 

  def self.transact_and_send_bid_notification bid 
    Transaction.create(user_id: bid.user_id , bid_id: bid.id , 
      transaction_type:TRANSACTION_TYPE[1],transaction_source:TRANSACTION_SOURCE[1],
      coins: COINS_PER_BID,transacted_at: Time.now )
    BidNotificationMailer.send_bid_notification(bid).deliver_now
  end 

  def self.get_coins user 
    transactions  = user.transactions
    return  coins = transactions.where(transaction_type: TRANSACTION_TYPE[0]).sum(:coins) - transactions.where(transaction_type: TRANSACTION_TYPE[1]).sum(:coins)     
  end 

  def self.accept_proposal_and_reject_other_bids proposal
    reject_bids = proposal.borrower_request.bids.where.not(id: proposal.id)
    proposal.update_attributes(status: BID_STATUS[:approved])
    BidNotificationMailer.send_bid_accept_notification(proposal).deliver_now
    if reject_bids.any?
      reject_bids.each do |bid| 
        bid.update_attributes(status: BID_STATUS[:rejected])        
        BidNotificationMailer.send_bid_reject_notification(bid).deliver_now  
      end 
    end 
  end 

  def self.bid_status status 
    case status
    when BID_STATUS[:sent]
      return BID_STATUS[:sent]
    when BID_STATUS[:rejected]
      return BID_STATUS[:rejected]
    when BID_STATUS[:approved]
      return BID_STATUS[:approved]
    end    
  end   

  def self.get_bid_status_text status 
    case status
    when BID_STATUS[:sent]
      return "Your bid is being reviewed by the borrower"
    when BID_STATUS[:rejected]
      return "Your bid has been <span style='color:red;'>rejected </span> by the borrower"
    when BID_STATUS[:approved]
      return "<span style='color:green;'>Borrower accepted </span> your bid"
    else
      return "<span style='color:blue;'>Borrower invited </span> you to bid on this request"
    end    
  end 

end
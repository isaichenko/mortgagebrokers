class MyDealsController < ApplicationController
  before_action :authenticate_user! , :check_role_access ,:get_coins
  before_action :set_deal_info , only: [:create_bid , :bid_request_info]  
  before_action :check_bid_availability , only: [:bid_request_info]
  before_action :handle_expired_requests

  def index
    @broker_invitations = current_user.broker_invitations
    @deals = BorrowerRequest.get_my_deals(@broker_invitations)
    @my_deals = params[:filter] ? Kaminari.paginate_array(filtered_deals(@deals,params[:filter])).page(params[:page]) : @deals.page(params[:page])    
    @deal_counts = BorrowerRequest.get_deals_count(@deals, current_user )
  end
  def bid_request_info
    @bid = Bid.new  
  end 
  def create_bid    
    @bid = Bid.new(bid_params)
    respond_to do |format|
      if @bid.save
        @bid.update_attributes(status: BID_STATUS[:sent])
        Bid.transact_and_send_bid_notification(@bid)        
        format.html { redirect_to my_deals_url, notice: 'Your Bid has been placed successfully' }
      else
        format.html { render :bid_request_info }
      end
    end    
  end   

  def contact_borrower 
    @borrower_request = BorrowerRequest.find(params[:id])
    @bid  = @borrower_request.bids.where(status: BID_STATUS[:approved]).first
  end

  private

  def set_deal_info 
    @my_deal  = BorrowerRequest.find(params[:id])
    @borrower = User.find(@my_deal.user_id) if @my_deal   
  end 

  def get_coins 
    @coins = Bid.get_coins(current_user) 
  end 

  def check_role_access    
    if current_user.role.name == BROKER 
      return true
    else
      redirect_to root_path, alert: 'Your dont have access to this'
    end 
  end 

  def check_bid_availability 
    if @my_deal.bids.size < MAX_BIDS_PER_REQUEST &&  @coins > COINS_PER_BID
      return true    
    else  
      if !(@my_deal.bids.size < MAX_BIDS_PER_REQUEST)
        redirect_to my_deals_url, alert: 'Maximum Requests reached. Try with another request'
      elsif @coins < COINS_PER_BID
        redirect_to my_deals_url, alert: 'No Sufficient coins to place a bid'
      end
    end 
  end 
  def filtered_deals deals , filter 
    if filter == BID_STATUS[:invited]
      return  deals.select{ |d|  !d.bids.any? }
    else
      return  deals.select{ |d|  d.bids.any? {|h| h.status== filter && h.user_id ==  current_user.id } }
    end 
  end 
  def bid_params
   params.require(:bid).permit(:rate ,:mortgage_type , :term ,:amortization ,:broker_fee ,:lender_fee ,:pre_payment_penalties ,:comments ,:status ,:user_id, :borrower_request_id)
  end
end

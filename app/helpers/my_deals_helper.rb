module MyDealsHelper
  def get_place place 
    return place[0][:city] + "," + place[0][:state] + "," + place[0][:country] 
  end 
  def get_closing_date bidding_end_time 
    return bidding_end_time.strftime("%d %b %Y")
  end 
  def get_bid_status_info deal 
    Bid.check_deal_exists(deal,current_user) 
  end
  def check_bid_status deal
    status = Bid.check_bids_for_user(deal,current_user)
    case status
    when BID_STATUS[:sent]
      return '<p><i class="fa fa-check"></i>BID SENT</p>'
    when BID_STATUS[:rejected]
      return "<i class='fa fa-trash'></i> DELETE"
    when BID_STATUS[:approved]
      return "<a class='btn btn-sm btn-warning' href='/my_deals/#{deal.id}/borrower_info'>CONTACT BORROWER</a>"
    when BID_STATUS[:invited]
      return "<a class='btn btn-sm btn-success' href='/my_deals/#{deal.id}/bid_request_info'>BID NOW</a>"
    else
      return 
    end      
  end
end

require './test/test_helper'

class BidTest < ActiveSupport::TestCase
  test "should save the bid with valid data" do
    bid = Bid.new(rate: 2 ,
      mortgage_type: BID_MORTGAGE_TYPES[1],
      term: TERM[1],
      amortization: 10,
      broker_fee: 3,
      lender_fee: 5,
      pre_payment_penalties: "test" ,
      comments: "test comments test comments test comments test comments test comments test comments test comments test comments ",
      status: "sent" ,
      user_id: 14 ,
      borrower_request_id: 13
    )
    assert bid.save
  end
  test "should not save bid without rate value " do
    bid = Bid.new(
      mortgage_type: BID_MORTGAGE_TYPES[1],
      term: TERM[1],
      amortization: 10,
      broker_fee: 3,
      lender_fee: 5,
      pre_payment_penalties: "test" ,
      comments: "test comments test comments test comments test comments test comments test comments test comments test comments ",
      status: "sent" ,
      user_id: 14 ,
      borrower_request_id: 13
      )
    assert !bid.save
  end
  test "rate value should  be in between 0 and 15 " do
    bid = Bid.new(rate: 100,
      mortgage_type: BID_MORTGAGE_TYPES[1],
      term: TERM[1],
      amortization: 10,
      broker_fee: 3,
      lender_fee: 5,
      pre_payment_penalties: "test" ,
      comments: "test comments test comments test comments test comments test comments test comments test comments test comments ",
      status: "sent" ,
      user_id: 14 ,
      borrower_request_id: 13
      )
    assert !bid.save
  end  
  test "comments characters should  be min 100 characters " do
    bid = Bid.new(rate: 2,
      mortgage_type: BID_MORTGAGE_TYPES[1],
      term: TERM[1],
      amortization: 10,
      broker_fee: 3,
      lender_fee: 5,
      pre_payment_penalties: "test" ,
      comments: "test comments",
      status: "sent" ,
      user_id: 14 ,
      borrower_request_id: 13
      )
    assert !bid.save
  end    
end

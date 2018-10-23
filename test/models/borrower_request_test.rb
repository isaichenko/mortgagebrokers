require './test/test_helper'

class BorrowerRequestTest < ActiveSupport::TestCase
  test "should save the borrower_request with valid data" do
    req = BorrowerRequest.new(mortgage_type: MORTGAGE_TYPES[1],
      property_address: "16th St, Denver, CO, USA",
      property_value: 59000,
      credit_score: 680 ,
      mortagage_level: "2nd Mortgage" ,
      description:"Commercial Town Complex" ,
      user_id: 15 ,
      place: [{"city"=>"Denver", "state"=>"Colorado", "country"=>"United States"}],
      latitude: 39.748140 ,
      longitude:-104.996008 ,
      status: "draft"
      )
    assert req.save
  end
  test "should not save user without property value " do
    req = BorrowerRequest.new(mortgage_type: MORTGAGE_TYPES[1],
      property_address: "16th St, Denver, CO, USA",
      credit_score: 680 ,
      mortagage_level: "2nd Mortgage" ,
      description:"Commercial Town Complex" ,
      user_id: 15 ,
      place: [{"city"=>"Denver", "state"=>"Colorado", "country"=>"United States"}],
      latitude: 39.748140 ,
      longitude:-104.996008 ,
      status: "draft"
      )
    assert !req.save
  end
  test "property value should  be > 50000" do
    req = BorrowerRequest.new(mortgage_type: MORTGAGE_TYPES[1],
      property_address: "16th St, Denver, CO, USA",
      property_value: 45000,
      credit_score: 680 ,
      mortagage_level: "2nd Mortgage" ,
      description:"Commercial Town Complex" ,
      user_id: 15 ,
      place: [{"city"=>"Denver", "state"=>"Colorado", "country"=>"United States"}],
      latitude: 39.748140 ,
      longitude:-104.996008 ,
      status: "draft"
      )
    assert !req.save
  end  
end

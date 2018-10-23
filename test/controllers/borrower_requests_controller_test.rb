require 'test_helper'

class BorrowerRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @borrower_request = borrower_requests(:one)
  end

  test "should get index" do
    get borrower_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_borrower_request_url
    assert_response :success
  end

  test "should create borrower_request" do
    assert_difference('BorrowerRequest.count') do
      post borrower_requests_url, params: { borrower_request: { bidding_end_time: @borrower_request.bidding_end_time, credit_score: @borrower_request.credit_score, description: @borrower_request.description, latitude: @borrower_request.latitude, longitude: @borrower_request.longitude, mortagage_level: @borrower_request.mortagage_level, mortgage_type: @borrower_request.mortgage_type, place: @borrower_request.place, property_address: @borrower_request.property_address, property_value: @borrower_request.property_value, status: @borrower_request.status, user_id: @borrower_request.user_id } }
    end

    assert_redirected_to borrower_request_url(BorrowerRequest.last)
  end

  test "should show borrower_request" do
    get borrower_request_url(@borrower_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_borrower_request_url(@borrower_request)
    assert_response :success
  end

  test "should update borrower_request" do
    patch borrower_request_url(@borrower_request), params: { borrower_request: { bidding_end_time: @borrower_request.bidding_end_time, credit_score: @borrower_request.credit_score, description: @borrower_request.description, latitude: @borrower_request.latitude, longitude: @borrower_request.longitude, mortagage_level: @borrower_request.mortagage_level, mortgage_type: @borrower_request.mortgage_type, place: @borrower_request.place, property_address: @borrower_request.property_address, property_value: @borrower_request.property_value, status: @borrower_request.status, user_id: @borrower_request.user_id } }
    assert_redirected_to borrower_request_url(@borrower_request)
  end

  test "should destroy borrower_request" do
    assert_difference('BorrowerRequest.count', -1) do
      delete borrower_request_url(@borrower_request)
    end

    assert_redirected_to borrower_requests_url
  end
end

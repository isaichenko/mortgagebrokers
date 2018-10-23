require 'test_helper'

class MyDealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_deals_index_url
    assert_response :success
  end

end

require "application_system_test_case"

class BorrowerRequestsTest < ApplicationSystemTestCase
  setup do
    @borrower_request = borrower_requests(:one)
  end

  test "visiting the index" do
    visit borrower_requests_url
    assert_selector "h1", text: "Borrower Requests"
  end

  test "creating a Borrower request" do
    visit borrower_requests_url
    click_on "New Borrower Request"

    fill_in "Bidding Time", with: @borrower_request.bidding_end_time
    fill_in "Credit Score", with: @borrower_request.credit_score
    fill_in "Description", with: @borrower_request.description
    fill_in "Latitude", with: @borrower_request.latitude
    fill_in "Longitude", with: @borrower_request.longitude
    fill_in "Mortagage Level", with: @borrower_request.mortagage_level
    fill_in "Mortgage Type", with: @borrower_request.mortgage_type
    fill_in "Place", with: @borrower_request.place
    fill_in "Property Address", with: @borrower_request.property_address
    fill_in "Property Value", with: @borrower_request.property_value
    fill_in "Status", with: @borrower_request.status
    fill_in "User", with: @borrower_request.user_id
    click_on "Create Borrower request"

    assert_text "Borrower request was successfully created"
    click_on "Back"
  end

  test "updating a Borrower request" do
    visit borrower_requests_url
    click_on "Edit", match: :first

    fill_in "Bidding Time", with: @borrower_request.bidding_end_time
    fill_in "Credit Score", with: @borrower_request.credit_score
    fill_in "Description", with: @borrower_request.description
    fill_in "Latitude", with: @borrower_request.latitude
    fill_in "Longitude", with: @borrower_request.longitude
    fill_in "Mortagage Level", with: @borrower_request.mortagage_level
    fill_in "Mortgage Type", with: @borrower_request.mortgage_type
    fill_in "Place", with: @borrower_request.place
    fill_in "Property Address", with: @borrower_request.property_address
    fill_in "Property Value", with: @borrower_request.property_value
    fill_in "Status", with: @borrower_request.status
    fill_in "User", with: @borrower_request.user_id
    click_on "Update Borrower request"

    assert_text "Borrower request was successfully updated"
    click_on "Back"
  end

  test "destroying a Borrower request" do
    visit borrower_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Borrower request was successfully destroyed"
  end
end

json.extract! borrower_request, :id, :mortgage_type, :property_address, :property_value, :credit_score, :mortagage_level, :description, :user_id, :place, :latitude, :longitude, :status, :bidding_end_time, :created_at, :updated_at
json.url borrower_request_url(borrower_request, format: :json)

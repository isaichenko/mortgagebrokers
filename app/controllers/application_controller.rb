class ApplicationController < ActionController::Base

  def handle_expired_requests
    BorrowerRequest.handle_expired_borrower_requests
  end 
  protected
  def after_sign_in_path_for(resource)
    if resource.role.name == BROKER && resource.verification_status == BROKER_NOT_VERIFIED
       new_profile_path 
    elsif resource.role.name == BORROWER
      borrower_requests_path
    else
     root_path
    end
  end 
end
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :get_roles

  def get_roles
  	@roles  = Role.where("name not in('Admin','Lender')").map{ |u| ["I'M A " + u.name.upcase, u.id] }
  end
  
  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password,:role_id)
  end
end

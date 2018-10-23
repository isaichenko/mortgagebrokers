class AddVerificationStatusToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users , :verification_status , :string , default: "not_verified"
  end
end

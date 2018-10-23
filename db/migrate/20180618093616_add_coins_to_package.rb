class AddCoinsToPackage < ActiveRecord::Migration[5.2]
  def change
  	add_column :packages , :coins , :integer
  end
end

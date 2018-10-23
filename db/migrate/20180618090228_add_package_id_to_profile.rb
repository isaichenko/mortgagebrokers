class AddPackageIdToProfile < ActiveRecord::Migration[5.2]
  def change
  	add_column :profiles , :package_id , :integer
  end
end

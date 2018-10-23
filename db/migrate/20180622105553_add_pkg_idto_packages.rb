class AddPkgIdtoPackages < ActiveRecord::Migration[5.2]
  def change
    add_column :packages , :stripe_package_id ,:string
  end
end

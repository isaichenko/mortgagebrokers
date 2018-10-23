class AddFieldBenefitDescriptionToPackage < ActiveRecord::Migration[5.2]
  def change
  	add_column :packages , :benefit_description , :text
  end
end

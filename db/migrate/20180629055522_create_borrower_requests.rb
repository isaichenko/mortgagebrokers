class CreateBorrowerRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :borrower_requests do |t|
      t.string :mortgage_type
      t.text :property_address
      t.integer :property_value
      t.integer :credit_score
      t.string :mortagage_level
      t.text :description
      t.integer :user_id
      t.text :place
      t.decimal :latitude , precision: 10, scale: 6
      t.decimal :longitude , precision: 10, scale: 6
      t.string :status , default: 'draft'
      t.datetime :bidding_time

      t.timestamps
    end
  end
end

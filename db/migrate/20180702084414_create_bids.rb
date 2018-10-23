class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.decimal :rate
      t.string :mortgage_type
      t.string :term
      t.integer :amortization
      t.decimal :broker_fee
      t.decimal :lender_fee
      t.string :pre_payment_penalties
      t.text :comments
      t.string :status
      t.integer :user_id 
      t.integer :borrower_request_id

      t.timestamps
    end
  end
end

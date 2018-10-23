class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :bid_id
      t.string :transaction_type
      t.string :transaction_source
      t.integer :coins
      t.datetime :transacted_at

      t.timestamps
    end
  end
end

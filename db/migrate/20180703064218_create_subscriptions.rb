class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :package_id
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.string :stripe_invoice_id
      t.boolean :is_active
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end

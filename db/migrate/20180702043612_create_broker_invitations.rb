class CreateBrokerInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :broker_invitations do |t|
      t.integer :borrower_request_id
      t.integer :user_id
      t.datetime :invitation_sent_at
      t.timestamps
    end
  end
end

class AddPublishedAtToBorrowerRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :borrower_requests , :published_at ,:datetime
  end
end

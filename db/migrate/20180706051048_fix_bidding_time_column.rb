class FixBiddingTimeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :borrower_requests, :bidding_time, :bidding_end_time
  end
end

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :title
      t.text :languages
      t.text :mortgage_types
      t.text :areas
      t.string :company
      t.text :company_address
      t.text :telephone_numbers
      t.string :facebook_link
      t.string :twitter_link
      t.string :youtube_link
      t.string :linked_in_link
      t.text :description
      t.integer :user_id
      t.timestamps
    end
  end
end

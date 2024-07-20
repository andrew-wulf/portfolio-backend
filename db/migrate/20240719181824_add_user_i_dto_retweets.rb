class AddUserIDtoRetweets < ActiveRecord::Migration[7.1]
  def change
    add_column :retweets, :user_id, :integer
  end
end

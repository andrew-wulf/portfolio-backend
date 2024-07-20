class AddCounts < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :follower_count, :integer, default: 0
    add_column :users, :following_count, :integer, default: 0
    add_column :tweets, :like_count, :integer, default: 0
    add_column :tweets, :retweet_count, :integer, default: 0
    add_column :tweets, :reply_count, :integer, default: 0
  end
end

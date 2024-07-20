class FixTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :is_retweet, :boolean, default: false
    remove_column :retweets, :user_id, :integer
    add_column :retweets, :retweet_id, :integer
  end
end

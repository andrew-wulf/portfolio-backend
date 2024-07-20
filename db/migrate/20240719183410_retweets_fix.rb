class RetweetsFix < ActiveRecord::Migration[7.1]
  def change
    remove_column :retweets, :is_retweet, :integer
    add_column :retweets, :is_retweet, :boolean, default: true
  end
end

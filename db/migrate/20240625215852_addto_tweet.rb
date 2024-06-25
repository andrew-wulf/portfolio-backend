class AddtoTweet < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :is_subtweet, :boolean, default: false
    add_column :tweets, :is_quote, :boolean, default: false
  end
end

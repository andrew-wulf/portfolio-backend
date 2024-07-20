class Spaghetti < ActiveRecord::Migration[7.1]
  def change
    add_column :retweets, :is_retweet, :integer, default: true
  end
end

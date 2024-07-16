class AddTimestamptoRetweet < ActiveRecord::Migration[7.1]
  def change
    add_column :retweets, :timestamp, :datetime
  end
end

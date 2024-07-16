class AddViewstoTweet < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :views, :integer, default: 0
  end
end

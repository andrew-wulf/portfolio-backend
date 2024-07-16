class AddTimestamp < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :timestamp, :datetime
  end
end

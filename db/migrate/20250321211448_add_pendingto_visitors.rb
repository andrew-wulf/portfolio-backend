class AddPendingtoVisitors < ActiveRecord::Migration[7.1]
  def change
    add_column :visitors, :pending, :boolean, default: false
  end
end

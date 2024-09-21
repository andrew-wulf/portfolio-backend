class ChangePlayerDefault < ActiveRecord::Migration[7.1]
  def change
    change_column :lobbies, :player1, :string, default: nil
    change_column :lobbies, :player2, :string, default: nil
    change_column :lobbies, :player3, :string, default: nil
    change_column :lobbies, :player4, :string, default: nil
    change_column :lobbies, :player5, :string, default: nil
    change_column :lobbies, :player6, :string, default: nil
    change_column :lobbies, :player7, :string, default: nil
    change_column :lobbies, :player8, :string, default: nil
  end
end

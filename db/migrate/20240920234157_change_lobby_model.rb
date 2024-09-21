class ChangeLobbyModel < ActiveRecord::Migration[7.1]
  def change
    remove_column :lobbies, :player1, :string
    remove_column :lobbies, :player2, :string
    remove_column :lobbies, :player3, :string
    remove_column :lobbies, :player4, :string
    remove_column :lobbies, :player5, :string
    remove_column :lobbies, :player6, :string
    remove_column :lobbies, :player7, :string
    remove_column :lobbies, :player8, :string
  end
end

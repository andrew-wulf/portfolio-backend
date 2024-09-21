class CreateLobbies < ActiveRecord::Migration[7.1]
  def change
    create_table :lobbies do |t|

      t.string :code
      
      t.boolean :active, default: true
      t.boolean :full, default: false

      t.string :player1, default: false
      t.string :player2, default: false
      t.string :player3, default: false
      t.string :player4, default: false
      t.string :player5, default: false
      t.string :player6, default: false
      t.string :player7, default: false
      t.string :player8, default: false

      t.timestamps
    end
  end
end

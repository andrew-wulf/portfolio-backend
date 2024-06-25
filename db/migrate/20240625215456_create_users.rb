class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :display_name
      t.string :avi
      t.string :banner
      t.string :bio
      t.boolean :verified, default: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end

class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :text
      t.string :image
      t.string :video
      t.boolean :edited, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end

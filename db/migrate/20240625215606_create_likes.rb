class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :tweet_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end

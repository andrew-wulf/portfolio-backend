class CreateSubtweets < ActiveRecord::Migration[7.1]
  def change
    create_table :subtweets do |t|
      t.integer :tweet_id
      t.integer :sub_id

      t.timestamps
    end
  end
end

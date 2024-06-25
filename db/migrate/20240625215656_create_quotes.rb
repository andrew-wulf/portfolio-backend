class CreateQuotes < ActiveRecord::Migration[7.1]
  def change
    create_table :quotes do |t|
      t.integer :tweet_id
      t.integer :quoted_id

      t.timestamps
    end
  end
end

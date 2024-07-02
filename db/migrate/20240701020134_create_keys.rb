class CreateKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :keys do |t|
      t.string :api
      t.string :key1
      t.string :key2
      t.string :key3

      t.timestamps
    end
  end
end

class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.string :site

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id,    null: false
      t.string :name,         null: false
      t.text :item_details,   null: false
      t.integer :price,       null: false
      t.boolean :is_sold_out, null: false, default: true
      t.timestamps
    end
  end
end

class CreateProduct < ActiveRecord::Migration
  def change
    create_table :products, force: true do |t|
      t.string :sku, index: true
      t.string :title, index: true
      t.string :field1
      t.string :field2
      t.string :field3
      t.string :field4
      t.integer :count
      t.decimal :price, precision: 8, scale: 2
      t.timestamps
    end
  end
end

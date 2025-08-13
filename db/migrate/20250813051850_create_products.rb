class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string  :product_code, null: false
      t.string  :name,         null: false
      t.decimal :price,        precision: 10, scale: 2, null: false, default: 0
      t.integer :discount_rule, null: true # enum (nil allowed)
      t.integer :discount_percentage, null: true
      t.integer :discount_threshold,  null: true
      t.timestamps
    end
    add_index :products, :product_code, unique: true
  end
end

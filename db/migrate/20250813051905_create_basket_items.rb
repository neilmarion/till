class CreateBasketItems < ActiveRecord::Migration[8.0]
  def change
    create_table :basket_items do |t|
      t.references :basket,  null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end

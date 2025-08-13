class CreateBaskets < ActiveRecord::Migration[8.0]
  def change
    create_table :baskets do |t|
      t.decimal :total_price, precision: 10, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end

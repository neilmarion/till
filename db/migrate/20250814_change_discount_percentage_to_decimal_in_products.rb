class ChangeDiscountPercentageToDecimalInProducts < ActiveRecord::Migration[8.0]
  def up
    change_column :products, :discount_percentage, :decimal, precision: 5, scale: 2
  end

  def down
    if connection.adapter_name.downcase.include?("postgres")
      change_column :products, :discount_percentage, :integer, using: "round(discount_percentage)"
    else
      change_column :products, :discount_percentage, :integer
    end
  end
end

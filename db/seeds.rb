Product.destroy_all
Basket.destroy_all
BasketItem.destroy_all

# GR1 Green Tea (BOGO example)
Product.create!(
  product_code: 'GR1', name: 'Green Tea', price: 3.11, discount_rule: :bogo
)

# SR1 Strawberry (bulk discount: 4+ items -> 60% off each)
Product.create!(
  product_code: 'SR1', name: 'Strawberry', price: 5.00,
  discount_rule: :bulk_discount, discount_threshold: 3, discount_percentage: 10
)

# CF1 Coffee (no discount)
Product.create!(
  product_code: 'CF1', name: 'Coffee', price: 11.23,
  discount_rule: :bulk_discount, discount_threshold: 3, discount_percentage: 33.3333
)

puts "Seeded: #{Product.count} products"

require 'rails_helper'

RSpec.describe PriceCalculator do
  def cents(dec)
    (dec.to_d * 100).round
  end

  it 'calculates normal price when no discounts' do
    p = Product.create!(product_code: 'X1', name: 'X', price: 2.00)
    b = Basket.create!
    3.times { BasketItem.create!(basket: b, product: p) }

    described_class.recalculate!(b)
    expect(cents(b.total_price)).to eq(600)
  end

  it 'applies BOGO correctly for odd/even counts' do
    p = Product.create!(product_code: 'S', name: 'Straw', price: 2.00, discount_rule: :bogo)
    b = Basket.create!

    5.times { BasketItem.create!(basket: b, product: p) } # pay for 3
    described_class.recalculate!(b)
    expect(cents(b.total_price)).to eq(600)

    BasketItem.create!(basket: b, product: p)            # now 6 -> pay for 3
    described_class.recalculate!(b)
    expect(cents(b.total_price)).to eq(600)
  end

  it 'applies bulk discount when threshold met' do
    p = Product.create!(product_code: 'B', name: 'Bulk', price: 2.00,
                        discount_rule: :bulk_discount, discount_threshold: 4, discount_percentage: 60)
    b = Basket.create!

    5.times { BasketItem.create!(basket: b, product: p) } # 5 * 0.80 = 4.00 total
    described_class.recalculate!(b)
    expect(cents(b.total_price)).to eq(400)
  end

  it 'combines multiple products with different rules' do
    bogo = Product.create!(product_code: 'G', name: 'Green', price: 3.11, discount_rule: :bogo)
    bulk = Product.create!(product_code: 'S', name: 'Straw', price: 5.00,
                           discount_rule: :bulk_discount, discount_threshold: 4, discount_percentage: 60)
    none = Product.create!(product_code: 'C', name: 'Coffee', price: 11.23)

    b = Basket.create!

    3.times { BasketItem.create!(basket: b, product: bogo) }  # pay for 2 -> 6.22
    4.times { BasketItem.create!(basket: b, product: bulk) }  # 4 * 2.00 = 8.00
    1.times { BasketItem.create!(basket: b, product: none) }  # 11.23

    described_class.recalculate!(b)
    expect(b.total_price.to_d).to eq(BigDecimal('25.45')) # 6.22 + 8.00 + 11.23
  end
end

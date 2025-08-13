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
end

class Basket < ApplicationRecord
  has_many :basket_items, dependent: :destroy

  def total_money
    Money.new((total_price.to_d * 100).round, "EUR")
  end

  def recompute_total!
    PriceCalculator.recalculate!(self)
  end
end

class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :product

  before_validation :snapshot_price, on: :create

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def price_money
    Money.new((price.to_d * 100).round, "EUR")
  end

  private
  def snapshot_price
    self.price = product.price if product
  end
end

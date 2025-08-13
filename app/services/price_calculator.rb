class PriceCalculator
  def self.recalculate!(basket)
    new(basket).recalculate!
  end

  def initialize(basket)
    @basket = basket
  end

  def recalculate!
    total_cents = compute_total_cents
    @basket.update!(total_price: (BigDecimal(total_cents) / 100))
  end

  private

  def compute_total_cents
    items_by_product = @basket.basket_items.includes(:product).group_by(&:product)

    items_by_product.sum do |product, items|
      count = items.size
      unit_cents = to_cents(product.price)

      unit_cents * count
    end
  end

  def to_cents(decimal)
    (decimal.to_d * 100).round(0).to_i
  end
end

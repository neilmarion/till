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

      case product.discount_rule&.to_sym
      when :bogo
        paid_units = count - (count / 2) # e.g., 5 -> pay 3; 6 -> pay 3
        paid_units * unit_cents
      when :bulk_discount
        threshold = product.discount_threshold
        pct       = product.discount_percentage
        if threshold.present? && pct.present? && count >= threshold
          discounted_unit_cents = (unit_cents * (100.00 - pct)) / 100.00
          discounted_unit_cents * count
        else
          unit_cents * count
        end
      else
        unit_cents * count
      end
    end
  end

  def to_cents(decimal)
    (decimal.to_d * 100).round(0).to_i
  end
end

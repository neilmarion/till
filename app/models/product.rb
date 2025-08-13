class Product < ApplicationRecord
  enum :discount_rule, { bogo: 0, bulk_discount: 1 }

  validates :product_code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validate :bulk_fields_requirements

  has_many :basket_items

  def price_money
    Money.new((price.to_d * 100).round, 'EUR')
  end

  private

  def bulk_fields_requirements
    case discount_rule&.to_sym
    when :bulk_discount
      if discount_threshold.blank? || discount_percentage.blank?
        errors.add(:base, 'Bulk discount requires discount_threshold and discount_percentage')
      end
    when :bogo
      if discount_threshold.present? || discount_percentage.present?
        errors.add(:base, 'BOGO should not set threshold or percentage')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Baskets', type: :request do
  before do
    @gr1 = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11, discount_rule: :bogo)
    @sr1 = Product.create!(product_code: 'SR1', name: 'Strawberry', price: 5.00,
                           discount_rule: :bulk_discount, discount_threshold: 4, discount_percentage: 60)
  end

  it 'creates a basket and adds items, recomputing totals' do
    # create
    post baskets_path
    basket = Basket.order(:created_at).last
    expect(response).to redirect_to(edit_basket_path(basket))

    # add items: 2x GR1 -> pay 1 * 3.11
    2.times { post basket_basket_items_path(basket), params: { product_id: @gr1.id } }
    basket.reload
    expect(basket.total_price.to_d).to eq(BigDecimal('3.11'))

    # add items: 4x SR1 -> 4 * 2.00 = 8.00
    4.times { post basket_basket_items_path(basket), params: { product_id: @sr1.id } }
    basket.reload
    expect(basket.total_price.to_d).to eq(BigDecimal('11.11')) # 3.11 + 8.00

    # delete one SR1 -> threshold breaks, SR1 now 3 * 5.00 = 15.00
    item = basket.basket_items.where(product_id: @sr1.id).first
    delete basket_basket_item_path(basket, item)
    basket.reload
    expect(basket.total_price.to_d).to eq(BigDecimal('18.11')) # 3.11 + 15.00
  end
end

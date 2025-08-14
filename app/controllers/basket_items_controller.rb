class BasketItemsController < ApplicationController
  before_action :set_basket

  def create
    product = Product.find(params[:product_id])
    @basket.basket_items.create!(product: product)
    @basket.recompute_total!
    redirect_to edit_basket_path(@basket)
  end

  def destroy
    item = @basket.basket_items.find(params[:id])
    item.destroy
    @basket.recompute_total!
    redirect_to edit_basket_path(@basket)
  end

  private
  def set_basket
    @basket = Basket.find(params[:basket_id])
  end
end

class BasketsController < ApplicationController
  before_action :set_basket, only: [:edit, :destroy]

  def index
    @baskets = Basket.includes(basket_items: :product).order(id: :desc)
  end

  def new; end

  def create
    basket = Basket.create!(total_price: 0)
    redirect_to edit_basket_path(basket)
  end

  def edit
    @products = Product.order(:name)
    @basket.recompute_total!
  end

  def destroy
    @basket.destroy
    redirect_to baskets_path, notice: 'Basket deleted.'
  end

  private
  def set_basket
    @basket = Basket.find(params[:id])
  end
end

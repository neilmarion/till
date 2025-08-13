class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update]

  def index
    @products = Product.order(:product_code)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'Product saved.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Product updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_code, :name, :price, :discount_rule, :discount_percentage, :discount_threshold)
  end
end

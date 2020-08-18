class ProductsController < ApplicationController
  before_action :set_product, only: [:index, :edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.all
    @images = Image.all
  end

  def new
    @product = Product.new
    @images = @product.images.build
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
    @images = @product.images
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
      render :delete unless @product.user_id == current_user.id && @product.destroy
      redirect_to root_path
  end

  def search
    @products = Product.search(params[:keyword])
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :product_explanation, :brand, :product_status_id, :shipping_method_id, :shipping_charge_id, :prefecture_id, :days_until_shipping_id, :price, :status, images_attributes: [:src, :src_cache, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end

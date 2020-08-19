class ProductsController < ApplicationController
  before_action :set_product, only: [:index, :edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.all
    @images = Image.all
    @q = Product.ransack(params[:q])
    @products =@q.result(distinct: true)
  end

  def new
    @product = Product.new
    @images = @product.images.build
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to product_path(@product), notice: "#{@product.product_name}を出品しました"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @images = @product.images
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), notice: "#{@product.product_name}を更新しました"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
      render :delete unless @product.user_id == current_user.id && @product.destroy
      redirect_to root_path, notice: "#{@product.product_name}を削除しました"
  end

  def search
    @products = Product.search(params[:keyword])
    @q = Product.search(search_params)
    @products = @q.result(distinct: true)
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :product_explanation, :brand, :product_status_id, :shipping_method_id, :shipping_charge_id, :prefecture_id, :days_until_shipping_id, :price, :status, images_attributes: [:src, :src_cache, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def search_params
    params.require(:q).permit!
  end
end

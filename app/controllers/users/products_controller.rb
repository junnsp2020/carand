class Users::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    if @product.save
      redirect_to product_path(@product.id)
    else
      render :index
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def product_params
    params.require(:product).permit(:category_id, :user_id, :name, :image_id, :introduction, :status, :price, :profit)
end
end

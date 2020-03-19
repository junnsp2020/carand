class Users::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
     trading = @product.build_trading
    @product_comment = ProductComment.new
    @product_comments = @product.product_comments
    # @trading = Trading.find(params[:trading_id])
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
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def product_params
    params.require(:product).permit(:category_id, :user_id, :name, :image, :introduction, :status, :price, :profit, :postage, :postage_responsibility, :sale_status, :propriety)
end
end

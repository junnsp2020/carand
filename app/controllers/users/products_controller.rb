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
     # trading = @product.build_trading
    @product_comment = ProductComment.new
    @product_comments = @product.product_comments
    @tradings = Trading.where(product_id: @product.id)
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
      redirect_to my_product_products_path
    else
      render :edit
    end
  end

  def my_product
    @products = Product.where(user_id: current_user.id, sale_status: 0)
  end

  def destroy
  end

  def search
    if params[:name].present?
      @products = Product.where('name LIKE ?', "%#{params[:name]}%")
    else
      @products = Product.all
    end
  end

  private
#   def calculate(user)
#     balance = 0
#     profit = 0
#   products.each do |product|
#   if product.profit != nil && product.sale_status == "売り切れ"
#   product.user.balance += product.profit
#   # binding.pry
#   product.user.balance.save
#   end
#   end
# end
  def product_params
    params.require(:product).permit(:category_id, :user_id, :name, :image, :introduction, :status, :price, :profit, :postage, :postage_responsibility, :sale_status, :propriety, :notice, :barter_propriety)
end
end

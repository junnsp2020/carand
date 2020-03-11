class Users::TradingsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @tradings = @product.tradings
    @trading = Trading.new
    @users = User.where(user_id: current_user.id)
  end

  def index
    @tradings = Trading.all
  end

  def show
    @trading = Trading.find(params[:id])
    @buyer = Trading.where(buyer_id: current_user.id)
    @seller = Trading.where(seller_id: current_user.id)
  end

  def create
    @product = Product.find(params[:product_id])
    @tradings = @product.tradings
    @trading = Trading.new(trading_params)
    @trading.product_id = @product.id
    @trading.user_id = current_user.id
    if @trading.save
      redirect_to products_path
    else
      @tradings = @product.tradings
      render :new
    end
  end

  def bought
    @tradings = Trading.where(buyer_id: current_user.id)
  end

  def sold
    @tradings = Trading.where(seller_id: current_user.id)
  end

  def edit
  end

  def update
  end

  private
  def trading_params
    params.require(:trading).permit(:product_id, :user_id, :status, :price, :profit, :paymethod, :buyer_id, :seller_id)
end
end

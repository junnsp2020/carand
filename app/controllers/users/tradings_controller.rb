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
  end

  def create
    buyer = current_user.active_tradings.build(seller_id: params[:user_id])
    buyer.save
    @product = Product.find(params[:product_id])
    @trading = Trading.new(trading_params)
    @trading.product_id = @product.id
    @trading.user_id = current_user.id
    if @trading.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
  def trading_params
    params.require(:trading).permit(:product_id, :user_id, :status, :price, :profit, :paymethod)
end
end

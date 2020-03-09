class Users::TradingsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @tradings = @product.tradings
    @trading = Trading.new
    @users = User.where(user_id: current_user.id)
  end

  def index
  end

  def show
  end

  def create
    @product = Product.find(params[:product_id])
    @trading = Trading.new(trading_params)
    @trading.product_id = @product.id
    @trading.user_id = current_user.id
    if @trading.save
      redirect_to product_path(@product.id)
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

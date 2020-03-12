class Users::TradingsController < ApplicationController
  before_action :payment_status_set, only: [:show, :edit, :update, :change_payment_status]
  before_action :shipment_status_set, only: [:show, :edit, :update, :change_shipment_status]
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
      redirect_to trading_path(@trading)
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

  def change_payment_status
    @trading.change_payment_status!
    redirect_to  request.referer
  end

  def change_shipment_status
    @trading.change_shipment_status!
    redirect_to  request.referer
  end

  private
  def trading_params
    params.require(:trading).permit(:product_id, :user_id, :price, :profit, :paymethod, :buyer_id, :seller_id, :paypment_status, :shipment_status)
  end
  def payment_status_set
    @trading = Trading.find(params[:id] || params[:trading_id])
  end
  def shipment_status_set
    @trading = Trading.find(params[:id] || params[:trading_id])
  end
end

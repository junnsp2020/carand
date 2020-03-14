class Users::TradingsController < ApplicationController
  before_action :payment_status_set, only: [:show, :edit, :update, :change_payment_status]
  before_action :shipment_status_set, only: [:show, :edit, :update, :change_shipment_status]
  def new
    @product = Product.find(params[:product_id])
     trading = @product.trading
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
    # @excellent = Trading.new
    # @good = Trading.new
    # @poor = Trading.new
    # @product = Product.find(params[:product_id])
    # @product = Product.find(params[:product_id])  #追加→削除
    # @excellent.product_id = @product.id  #追加  undefined method `id' for nil:NilClass  →削除
    # @excellent.user_id = current_user.id  #追加
    @review = Trading.new
    # @user = @product.user
    # @user = current_user
  end

  def create
    @product = Product.find(params[:product_id])
    @product.save ##追加
    @trading = @product.trading
    @trading = Trading.new(trading_params)
    @trading.product_id = @product.id
    @trading.user_id = current_user.id
    @review = Trading.new(trading_params)
    # if @review
    #   @review.save ##追加
    # end
    # @excellent = @product.excellent
    # @good = @product.good
    # @poor = @product.poor
    # @excellent = Trading.new(trading_params)  #追加
    # @good =Trading.new(trading_params)  #追加
    # @poor =Trading.new(trading_params)  #追加

    # @excellent.product_id = @product.id
    # @excellent.user_id = current_user.id
    # @good.product_id = @product.id
    # @good.user_id = current_user.id
    # @poor.product_id = @product.id
    # @poor.user_id = current_user.id
      @trading.soldout = true
      @trading.save
      redirect_to trading_path(@trading)

    # @tradings = @product.tradings
  end

    # @excellent = Trading.new(trading_params)
    # if @excellent
    #   @excellent.save
    # end
    # @good = Trading.new(trading_params)
    # if @good
    # @good.save
    # end
    # @poor = Trading.new(trading_params)
    # if @poor
    # @poor.save
    # end


  def bought
    @tradings = Trading.where(buyer_id: current_user.id)
  end

  def sold
    @tradings = Trading.where(seller_id: current_user.id)
  end

  def edit
  end

  def update
    @trading = Trading.find(params[:id])
    if @trading.update(trading_params)
      redirect_to  request.referer
    else
      render :show
    end
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
    params.require(:trading).permit(:product_id, :user_id, :price, :profit, :paymethod, :buyer_id, :seller_id, :paypment_status, :shipment_status, :excellent_review, :good_review, :poor_review, :soldout, :seller_excellent_review, :good_excellent_review, :poor_excellent_review)
  end
  def payment_status_set
    @trading = Trading.find(params[:id] || params[:trading_id])
  end
  def shipment_status_set
    @trading = Trading.find(params[:id] || params[:trading_id])
  end
end

class Users::TradingsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
     trading = @product.trading
    @trading = Trading.new
    # trading.price = @product.price
    @users = User.where(user_id: current_user.id)
  end

  def index
    @tradings = Trading.all
  end

  def show
    @trading = Trading.find(params[:id])
    @buyer = Trading.where(buyer_id: current_user.id)
    @seller = Trading.where(seller_id: current_user.id)
    @trading_message = TradingMessage.new
    @trading_messages = @trading.trading_messages
    # @trading.total_price = calculate(current_user)
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
    @product.sale_status = "売り切れ"
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
       # binding.pry
    if @trading.payment_status == "出品者へ入金報告をする"
      @trading.completed = false
    elsif @trading.payment_status == "受取報告をする"
      @trading.completed = false
    end

    @trading.save(trading_params)
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
    @trading = Trading.find(params[:trading_id])
    # @trading.change_payment_status!
    # if @trading.payment_status == "出品者へ入金報告をする"
    if @trading.payment_status == "出品者へ入金報告をする"
      @trading.payment_status = "入金報告をしました。出品者の発送待ちです"
      @trading.shipment_status = "出荷報告をする"
      # @trading.shipment_status = "出荷報告をする"
      # @trading.payment_status = "受取報告をする"
    elsif @trading.payment_status == "受取報告をする"
      @trading.payment_status = "ご利用誠にありがとうございました！"
      @trading.shipment_status = "購入者を評価する"
      @trading.completed = true
    end
    @trading.save
    redirect_to  request.referer
  end

  def change_shipment_status
    @trading = Trading.find(params[:trading_id])
    # @trading.change_shipment_status!
    if @trading.shipment_status == "出荷報告をする"
      @trading.shipment_status = "出荷を通知しました。購入者の評価待ちです"
      @trading.payment_status = "受取報告をする"
    # elsif @trading.shipment_status ==
    #   @trading.payment_status = "受取報告をする"
    #   @trading.shipment_status == "出荷を通知しました。購入者の評価待ちです"
    end
    @trading.save
    redirect_to  request.referer
  end

  private
  def trading_params
    params.require(:trading).permit(:product_id, :user_id, :toal_price, :profit, :paymethod, :buyer_id, :seller_id, :paypment_status, :shipment_status, :excellent_review, :good_review, :poor_review, :soldout, :seller_excellent_review, :good_excellent_review, :poor_excellent_review, :completed)
  end
end

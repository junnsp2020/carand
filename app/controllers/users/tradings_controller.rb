class Users::TradingsController < ApplicationController
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
    @trading_message = TradingMessage.new
    @trading_messages = @trading.trading_messages
    @review = Trading.new
  end

  def create
    @product = Product.find(params[:product_id])
    if @product.notice == false
      @product.notice = true
    end
    @product.sale_status = "売り切れ"
    @trading = @product.trading
    @trading = Trading.new(trading_params)
    @trading.product_id = @product.id
    @trading.user_id = current_user.id
    @review = Trading.new(trading_params)
    @barter_request = BarterRequest.find_by(product_id: @product.id)
    if @barter_request
      @barter_request.notice = false
      @barter_request.save
    end
    if @product.barter_approval != true && @trading.payment_status == "出品者へ入金報告をする"
      @trading.completed = false
    elsif @trading.payment_status == "受取報告をする"
      @trading.completed = false
    end

    if @product.barter_approval == true
      @trading.payment_status = "交換(購入者)"
      @trading.shipment_status = "交換(出品者)"
    end

    @trading.save(trading_params)
    @product.barter_approval = false
    @product.save
    redirect_to trading_path(@trading)
  end

  def bought
    @tradings = Trading.where("(paymethod = ?) OR (paymethod = ?) ", 0, 1).where(buyer_id: current_user.id)
    @buyer = Trading.where(buyer_id: current_user.id)
  end

  def sold
    @tradings = Trading.where("(paymethod = ?) OR (paymethod = ?) ", 0, 1).where(seller_id: current_user.id)
    @seller = Trading.where(seller_id: current_user.id)
  end

  def barter
    @tradings = Trading.where("(buyer_id = ?) OR (seller_id = ?) ", current_user.id, current_user.id).where(paymethod: 2)
    @seller = Trading.where(seller_id: current_user.id)
    @buyer = Trading.where(buyer_id: current_user.id)
  end

  def edit
  end

  def update
    @trading = Trading.find(params[:id])
    @buyer = Trading.find_by(buyer_id: current_user.id)
    @seller = Trading.find_by(seller_id: current_user.id)
    @trading_message = TradingMessage.new
    @trading_messages = @trading.trading_messages
    if @trading.update(trading_params)
      redirect_to  request.referer
    else
      render :show
    end
    if @trading.payment_status == "受取報告をする"
      @trading.payment_status = "ご利用誠にありがとうございました！"
      @trading.shipment_status = "購入者を評価する"
      @trading.save
    end
    if @trading.shipment_status == "購入者を評価する" && @trading.excellent_review == true
      @trading.shipment_status = "取引完了"
      @trading.save
      @seller = User.find(@trading.seller_id)
    if @seller.balance == nil
      @seller.balance = 0
      @seller.save
    end
      @seller.balance += @trading.product.profit
      @seller.save
    end
    if @trading.shipment_status == "購入者を評価する" && @trading.good_review == true
      @trading.shipment_status = "取引完了"
      @trading.save
    end
    if @trading.shipment_status == "購入者を評価する" && @trading.poor_review == true
      @trading.shipment_status = "取引完了"
      @trading.save
    end
    if @trading.payment_status == "番号確認完了(購入者)"
      @trading.payment_status = "交換お疲れ様でした(購入者)"
      @trading.save
    end
    if @trading.shipment_status == "番号確認完了(出品者)"
      @trading.shipment_status = "交換お疲れ様でした(出品者)"
      @trading.save
    end
  end

  def change_payment_status
    @trading = Trading.find(params[:trading_id])
    if @trading.payment_status == "出品者へ入金報告をする"
      @trading.payment_status = "入金報告をしました。出品者の発送待ちです"
      @trading.shipment_status = "出荷報告をする"
    elsif @trading.payment_status == "受取報告をする"
      @trading.payment_status = "ご利用誠にありがとうございました！"
      @trading.shipment_status = "購入者を評価する"
      @trading.completed = true
    end
    if @trading.payment_status == "交換(購入者)"
      @trading.payment_status = "番号確認完了(購入者)"
    end
    @trading.save
    redirect_to  request.referer
  end

  def change_shipment_status
    @trading = Trading.find(params[:trading_id])
    if @trading.shipment_status == "出荷報告をする"
      @trading.shipment_status = "出荷を通知しました。購入者の評価待ちです"
      @trading.payment_status = "受取報告をする"
    end
    if @trading.shipment_status == "交換(出品者)"
      @trading.shipment_status = "番号確認完了(出品者)"
    end
    @trading.save
    redirect_to  request.referer
  end

  private
  def trading_params
    params.require(:trading).permit(:product_id, :user_id, :toal_price, :profit, :paymethod, :buyer_id, :seller_id, :paypment_status, :shipment_status, :excellent_review, :good_review, :poor_review, :soldout, :seller_excellent_review, :seller_good_review, :seller_poor_review, :completed, :buyer_notice, :seller_notice)
  end
end

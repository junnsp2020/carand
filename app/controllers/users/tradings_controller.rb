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
    # @product = Product.find(params[:product_id])
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
    if @product.notice == false
    @product.notice = true
    end
    @product.sale_status = "売り切れ"
    # @product.save ##追加
    @trading = @product.trading
    @trading = Trading.new(trading_params)
    @trading.product_id = @product.id
    @trading.user_id = current_user.id
    @review = Trading.new(trading_params)
    @barter_request = BarterRequest.find_by(user_id: current_user.id)
    if @barter_request
      @barter_request.notice = false
      @barter_request.save
    end
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
    # @tradings = Trading.where(buyer_id: current_user.id)
    @tradings = Trading.where("(paymethod = ?) OR (paymethod = ?) ", 0, 1).where(buyer_id: current_user.id)
    @buyer = Trading.where(buyer_id: current_user.id)
  end

  def sold
    # @tradings = Trading.where(seller_id: current_user.id)
    @tradings = Trading.where("(paymethod = ?) OR (paymethod = ?) ", 0, 1).where(seller_id: current_user.id)
    @seller = Trading.where(seller_id: current_user.id)
  end

  def barter
    @tradings = Trading.where("(buyer_id = ?) OR (seller_id = ?) ", current_user.id, current_user.id).where(paymethod: 2)
    # @trading = Trading.find_by(seller_id: current_user.id)
    # @tradings = Trading.where(paymethod: 2, buyer_id: params[:user_id])
    # ("((payment_status = ?)OR(shipment_status = ?)) OR ((payment_status = ?) OR (shipment_status = ?))", 4, 4, 5, 5).where("((buyer_id = ?)OR(seller_id = ?))", current_user.id, current_user.id).count
    @seller = Trading.where(seller_id: current_user.id)
    @buyer = Trading.where(buyer_id: current_user.id)
  end

  def edit
  end

  def update
    @trading = Trading.find(params[:id])
    @buyer = Trading.find_by(buyer_id: current_user.id) #追加
    @seller = Trading.find_by(seller_id: current_user.id) #追加
    # @trading_message = current_user.trading_messages.new(trading_message_params) #追加
    # @trading_message.trading_id = @trading.id #追加
    # @trading_message.save
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
      # puts @seller.to_json
      @seller.balance += @trading.product.profit
      # puts @seller.to_json
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
    # if @seller.nil? == false
    #   if @trading_message.user_id == @seller.user_id  #3 undefined method `user_id' for nil:NilClass と出てしまう
    #     @trading.seller_notice = false
    #     @trading.buyer_notice = true
    #     @trading.save
    #   end
    # end
    # if @buyer.nil? == false
    #   if @trading_message.user_id == @buyer.buyer_id  #3 undefined method `user_id' for nil:NilClass と出てしまう
    #   # @seller = Trading.find_by(seller_id: current_user.id)
    #   #2 if @buyer.id == current_user.id
    #     @trading.buyer_notice = false
    #     @trading.seller_notice = true
    #     @trading.save
    #   end
    # end
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
    if @trading.payment_status == "交換(購入者)"
      @trading.payment_status = "番号確認完了(購入者)"
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

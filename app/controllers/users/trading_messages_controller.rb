class Users::TradingMessagesController < ApplicationController
  def create
  	@trading = Trading.find(params[:trading_id])
    # puts @trading.to_json
    # @buyer = Trading.find_by(buyer_id: current_user.id)
    # puts @buyer.to_json
    # @seller = Trading.find_by(seller_id: current_user.id)
    # puts @seller.to_json
	  @trading_message = current_user.trading_messages.new(trading_message_params)
    @trading_message.trading_id = @trading.id
    # @trading_messages = @buyer.trading_messages  undefined method `trading_messages' for nil:NilClass #2
    # @trading_messages = @seller.trading_messages  undefined method `trading_messages' for nil:NilClass #2
    #1 @trading_message.user_id = @buyer.id   undefined method `id' find_by でもwhereでも同じ
    # @trading_message.user_id = @seller.id  undefined method `id'
    @trading_message.save
    # if @buyer.buyer_id == @buyer.id
    # if @buyer.buyer_id == current_user.id
    # if @trading_message.user_id == @buyer.id  undefined method `id' for nil:NilClass と出たため #1を記入したが
    #   undefined method `save' for nil:NilClass と出てしまった
    # @buyer.save  #3をもって記入したが、undefined method `save' for nil:NilClass
    #2 @seller.save  #3をもって記入したが、undefined method `save' for nil:NilClass
    if current_user.id == @trading.seller_id
      @trading.buyer_notice = true
      @trading.seller_notice = false
      @trading.save
    else
      @trading.buyer_notice = false
      @trading.seller_notice = true
      @trading.save
    end
    # else
    # if @buyer.nil? == false
    #   if @trading_message.user_id == @buyer.buyer_id  #3 undefined method `user_id' for nil:NilClass と出てしまう
    #   # @seller = Trading.find_by(seller_id: current_user.id)
    #   #2 if @buyer.id == current_user.id
    #     @trading.buyer_notice = false
    #     @trading.seller_notice = true
    #   end
    # end
    # # if @seller == @seller.id
    # # if @seller.seller_id == current_user.id
    # # if @trading_message.user_id == @seller.id
    # if @seller.nil? == false
    #   if @trading_message.user_id == @seller.user_id  #3 undefined method `user_id' for nil:NilClass と出てしまう
    #     @trading.seller_notice = false
    #     @trading.buyer_notice = true
    #   end
    # end
    # @trading_message.save
    # @trading.save
    redirect_to trading_path(@trading)
  end

  def update
  end

  def destroy
  end

  private
  def trading_message_params
    params.require(:trading_message).permit(:message, :user_id, :trading_id, :buyer_notice, :seller_notice)
  end
end

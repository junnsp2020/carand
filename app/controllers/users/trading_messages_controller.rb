class Users::TradingMessagesController < ApplicationController
  def create
  	@trading = Trading.find(params[:trading_id])
    @buyer = Trading.find_by(buyer_id: current_user.id)
    @seller = Trading.find_by(seller_id: current_user.id)
	  @trading_message = current_user.trading_messages.new(trading_message_params)
    @trading_message.trading_id = @trading.id
    # @trading_messages = @buyer.trading_messages  undefined method `trading_messages' for nil:NilClass #2
    # @trading_messages = @seller.trading_messages  undefined method `trading_messages' for nil:NilClass #2
    # @trading_message.user_id = @buyer.id   undefined method `id' find_by でもwhereでも同じ
    # @trading_message.user_id = @seller.id  undefined method `id'
    @trading_message.save
    # if @buyer.buyer_id == @buyer.id
    # if @buyer.buyer_id == current_user.id
    # if @trading_message.user_id == @buyer.id  undefined method `id' for nil:NilClass と出たため #1を記入したが
    #   undefined method `save' for nil:NilClass と出てしまった
    @buyer.save  #3をもって記入したが、undefined method `save' for nil:NilClass
    #@seller.save  #3をもって記入したが、undefined method `save' for nil:NilClass
    if @trading_message.user_id == @buyer.buyer_id  #3 undefined method `user_id' for nil:NilClass と出てしまう
    # @seller = Trading.find_by(seller_id: current_user.id)
    # if @buyer.id == current_user.id
      @trading_message.buyer_notice = false
      @trading_message.seller_notice = true
    end
    # if @seller == @seller.id
    # if @seller.seller_id == current_user.id
    # if @trading_message.user_id == @seller.id
     if @trading_message.user_id == @seller.user_id  #3 undefined method `user_id' for nil:NilClass と出てしまう
      @trading_message.seller_notice = false
      @trading_message.buyer_notice = true
    end
    @trading_message.save
    redirect_to trading_path(@trading)
  end

  def destroy
  end

  private
  def trading_message_params
    params.require(:trading_message).permit(:message, :user_id, :trading_id, :buyer_notice, :seller_notice)
  end
end

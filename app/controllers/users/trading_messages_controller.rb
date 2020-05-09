class Users::TradingMessagesController < ApplicationController
  def create
  	@trading = Trading.find(params[:trading_id])
	  @trading_message = current_user.trading_messages.new(trading_message_params)
    @trading_message.trading_id = @trading.id
    @trading_message.save
    if current_user.id == @trading.seller_id
      @trading.buyer_notice = true
      @trading.seller_notice = false
      @trading.save
    else
      @trading.buyer_notice = false
      @trading.seller_notice = true
      @trading.save
    end
    redirect_to trading_path(@trading)
  end

  private
  def trading_message_params
    params.require(:trading_message).permit(:message, :user_id, :trading_id)
  end
end

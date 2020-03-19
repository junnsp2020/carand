class Users::TradingMessagesController < ApplicationController
  def create
  	@trading = Trading.find(params[:trading_id])
	@trading_message = current_user.trading_messages.new(trading_message_params)
    @trading_message.trading_id = @trading.id
    @trading_message.save
    redirect_to trading_path(@trading)
  end

  def destroy
  end

  private
  def trading_message_params
    params.require(:trading_message).permit(:message, :user_id, :trading_id)
  end
end

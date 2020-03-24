class AddBuyerNoticeToTradingMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :trading_messages, :buyer_notice, :boolean
  end
end

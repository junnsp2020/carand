class AddSellerNoticeToTradingMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :trading_messages, :seller_notice, :boolean
  end
end

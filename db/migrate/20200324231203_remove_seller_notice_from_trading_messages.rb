class RemoveSellerNoticeFromTradingMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :trading_messages, :seller_notice, :boolean
  end
end

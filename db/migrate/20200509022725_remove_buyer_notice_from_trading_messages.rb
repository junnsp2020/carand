class RemoveBuyerNoticeFromTradingMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :trading_messages, :buyer_notice, :boolean
  end
end

class AddBuyerNoticeToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :buyer_notice, :boolean
  end
end

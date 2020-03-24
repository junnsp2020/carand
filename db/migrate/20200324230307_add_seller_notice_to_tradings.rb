class AddSellerNoticeToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :seller_notice, :boolean
  end
end

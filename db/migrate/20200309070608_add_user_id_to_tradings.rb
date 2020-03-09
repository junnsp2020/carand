class AddUserIdToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :user_id, :integer
    add_column :tradings, :product_id, :integer
    add_column :tradings, :status, :integer, default: 0
    add_column :tradings, :profit, :integer
    add_column :tradings, :postage, :integer
    add_column :tradings, :paymethod, :integer
  end
end

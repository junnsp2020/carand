class AddBarterApprovalToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :barter_approval, :boolean
  end
end

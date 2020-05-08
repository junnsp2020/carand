class RemoveBarterApprovalFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :barter_approval, :boolean
  end
end

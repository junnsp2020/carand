class AddUserIdToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :user_id, :integer
    add_column :transfers, :request_amount, :integer
    add_column :transfers, :commission, :integer
    add_column :transfers, :amount, :integer
  end
end

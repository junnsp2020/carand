class AddRequestAmountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :request_amount, :integer
  end
end

class AddCommissionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :commission, :integer
  end
end

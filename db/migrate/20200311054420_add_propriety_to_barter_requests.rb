class AddProprietyToBarterRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :barter_requests, :propriety, :boolean
  end
end

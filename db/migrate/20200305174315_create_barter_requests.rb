class CreateBarterRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :barter_requests do |t|

      t.timestamps
    end
  end
end

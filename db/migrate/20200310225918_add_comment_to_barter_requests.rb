class AddCommentToBarterRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :barter_requests, :comment, :text
  end
end

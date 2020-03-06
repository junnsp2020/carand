class AddUserIdToBlogFollows < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_follows, :user_id, :integer
  end
end

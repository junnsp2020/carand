class AddUserIdToBlogComments < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_comments, :user_id, :integer
  end
end

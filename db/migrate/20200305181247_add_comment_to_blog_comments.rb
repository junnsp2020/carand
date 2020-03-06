class AddCommentToBlogComments < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_comments, :comment, :text
  end
end

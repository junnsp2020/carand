class AddBlogIdToBlogFollows < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_follows, :blog_id, :integer
  end
end

class DropTableBlogFollows < ActiveRecord::Migration[5.2]
  def change
  	drop_table :blog_follows
  end
end

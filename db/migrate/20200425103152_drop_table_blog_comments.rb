class DropTableBlogComments < ActiveRecord::Migration[5.2]
  def change
  	drop_table :blog_comments
  end
end

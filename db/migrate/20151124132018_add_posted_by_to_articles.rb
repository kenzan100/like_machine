class AddPostedByToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :posted_by, :integer
  end
end

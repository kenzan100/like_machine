class AddPostedAtToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :posted_at, :datetime
  end
end

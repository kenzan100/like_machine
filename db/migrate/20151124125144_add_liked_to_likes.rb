class AddLikedToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :liked, :boolean
  end
end

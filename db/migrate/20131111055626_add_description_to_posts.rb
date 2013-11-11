class AddDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :description, :string
    add_column :posts, :thumbnail_url, :text
  end
end

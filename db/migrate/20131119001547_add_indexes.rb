class AddIndexes < ActiveRecord::Migration
  def change
    add_index :posts, [:vine_id]
    add_index :users, [:vine_id]
    add_index :likes, [:vine_id]
    add_index :reposts, [:vine_id]
    add_index :comments, [:vine_id]
  end
end

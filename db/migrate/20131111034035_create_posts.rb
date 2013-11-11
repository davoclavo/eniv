class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :vine_id, index: true, uniq: true, null: false
      t.string :hashed_id, index: true, uniq: true
      t.references :user, index: true
      t.text :video_url
      t.text :reversed_video_url
      t.timestamps
    end
  end
end

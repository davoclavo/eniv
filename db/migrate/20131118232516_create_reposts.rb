class CreateReposts < ActiveRecord::Migration
  def change
    create_table :reposts do |t|
      t.string     :vine_id, index: true, uniq: true, null: false
      t.references :user,    index: true
      t.references :post,    index: true
      t.datetime   :vine_created_at
      t.timestamps
    end
  end
end

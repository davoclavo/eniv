class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string     :vine_id, index: true, uniq: true, null: false
      t.references :user,    index: true
      t.references :post,    index: true
      t.datetime   :vine_created_at
      t.timestamps
    end
  end
end

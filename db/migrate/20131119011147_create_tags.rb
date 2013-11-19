class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string  :vine_id,     index: true
      t.string  :name,        index: true
      t.timestamps
    end
  end
end

class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string     :title
      t.string     :range
      t.references :entity_type, index: true
      t.integer    :target_id,   index: true
      t.references :post,        index: true
      t.references :comment,     index: true
      t.timestamps
    end

    create_table :entity_types do |t|
      t.string :name, index: true
    end
  end
end

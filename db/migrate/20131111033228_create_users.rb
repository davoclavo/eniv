class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :vine_id, index: true, unique: true
      t.string :username
      t.timestamps
    end
  end
end

class CreateWatchings < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.integer :user_id, :null => false
      t.integer :title_id, :null => false
      t.index [:user_id, :title_id], :unique => true
      t.timestamps
    end
  end
end

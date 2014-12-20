class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :channel_group_id, null: false
      t.string :name, null: false
      t.timestamps
      t.index :channel_group_id
    end
  end
end

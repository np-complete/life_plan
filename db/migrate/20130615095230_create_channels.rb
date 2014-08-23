class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :channel_group_id, null: false, index: true
      t.string :name, null: false
      t.timestamps
    end
  end
end

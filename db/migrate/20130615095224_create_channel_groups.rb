class CreateChannelGroups < ActiveRecord::Migration
  def change
    create_table :channel_groups do |t|
      t.string :name, null: false
      t.timestamps
      t.index :name, unique: true
    end
  end
end

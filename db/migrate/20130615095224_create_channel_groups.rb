class CreateChannelGroups < ActiveRecord::Migration
  def change
    create_table :channel_groups do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end
  end
end

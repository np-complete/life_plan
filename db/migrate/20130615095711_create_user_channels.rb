class CreateUserChannels < ActiveRecord::Migration
  def change
    create_table :user_channels do |t|
      t.integer :user_id
      t.integer :channel_id
      t.timestamps
      t.index [:channel_id, :user_id], unique: true
    end
  end
end

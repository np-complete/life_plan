class CreateUserChannels < ActiveRecord::Migration
  def change
    create_table :user_channels do |t|
      t.integer :user_id
      t.integer :channel_id, :index => { with: [:user_id], unique: true}
      t.timestamps
    end
  end
end

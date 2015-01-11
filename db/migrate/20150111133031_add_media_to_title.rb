class AddMediaToTitle < ActiveRecord::Migration
  def change
    change_table :titles do |t|
      t.integer :media_id, null: false, default: 0
      t.index [:media_id, :kana]
    end
  end
end

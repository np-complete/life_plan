class AddIndexToKana < ActiveRecord::Migration
  def change
    add_index :titles, :kana
  end
end

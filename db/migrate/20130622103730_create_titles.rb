class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :name, :null => false
      t.string :kana, :default => nil
      t.datetime :started_at, :default => nil
      t.datetime :finished_at, :default => nil
      t.timestamps
    end
  end
end

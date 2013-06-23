class Title < ActiveRecord::Base
  attr_accessible :id, :name, :kana, :started_at, :finished_at
end

# -*- coding: utf-8 -*-
class Title < ActiveRecord::Base
  attr_accessible :id, :name, :kana, :started_at, :finished_at

  default_scope { order(:kana) }

  def self.begin_with(initial)
    where('SUBSTR(kana, 1, 1) IN (?)',  Title.initial_characters(initial))
  end

  def self.initial_characters(initial)
    @initials ||= {
      'あ' => %w{あ い う え お},
      'か' => %w{か き く け こ},
      'さ' => %w{さ し す せ そ},
      'た' => %w{た ち つ て と},
      'な' => %w{な に ぬ ね の},
      'は' => %w{は ひ ふ へ ほ},
      'ま' => %w{ま み む め も},
      'や' => %w{や ゆ よ},
      'ら' => %w{ら り る れ ろ},
      'わ' => %w{わ を}
    }
    @initials[initial]
  end
end

# -*- coding: utf-8 -*-
class Title < ActiveRecord::Base
  default_scope { order(:kana) }
  scope :unfinished, -> { where(finished_at: nil) }
  scope :current, -> { unfinished.where(media_id: Media::ANIME + Media::RADIO) }
  module Media
    ANIME = [1, 10]
    RADIO = [2]
    MOVIE = [8]
    OTHER = (0..10).to_a - ANIME - RADIO - MOVIE

    def self.valid?(media)
      constants.map(&:to_s).include?(media.upcase)
    end
  end

  Media.constants.each do |key|
    ids = "Title::Media::#{key}".constantize
    scope key.downcase, -> { where(media_id: ids) }
  end

  def self.begin_with(initial)
    where('SUBSTR(kana, 1, 1) IN (?)',  Title.initial_characters(initial))
  end

  def self.initial_characters(initial)
    @initials ||= {
      'あ' => %w(あ い う え お),
      'か' => %w(か き く け こ),
      'さ' => %w(さ し す せ そ),
      'た' => %w(た ち つ て と),
      'な' => %w(な に ぬ ね の),
      'は' => %w(は ひ ふ へ ほ),
      'ま' => %w(ま み む め も),
      'や' => %w(や ゆ よ),
      'ら' => %w(ら り る れ ろ),
      'わ' => %w(わ を)
    }
    @initials[initial]
  end
end

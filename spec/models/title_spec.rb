require 'rails_helper'

describe Title do
  describe :factory do
    it { expect(build(:title)).to be_valid }
  end

  describe Title::Media do
    it { expect(Title::Media::ANIME).to eq [1, 10] }
    it { expect(Title::Media::RADIO).to eq [2] }
    it { expect(Title::Media::MOVIE).to eq [8] }
    it { expect(Title::Media::OTHER).to eq [0, 3, 4, 5, 6, 7, 9] }
  end
end

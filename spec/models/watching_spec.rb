require 'rails_helper'

describe Watching do
  describe :factory do
    it { expect(build(:watching)).to be_valid }
  end
end

require 'spec_helper'

describe Title do
  describe :factory do
    it { expect(build(:title)).to be_valid }
  end
end

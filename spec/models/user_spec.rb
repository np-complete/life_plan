require 'spec_helper'

describe User do
  describe :factory do
    it { expect(build(:user)).to be_valid }
  end
end

require 'rails_helper'

describe UserChannel do
  describe :factory do
    it { expect(build(:user_channel)).to be_valid }
  end
end

require 'spec_helper'

describe ChannelGroup do
  describe :factory do
    it { expect(build(:channel_group)).to be_valid }
  end
end

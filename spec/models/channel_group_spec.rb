require 'spec_helper'

describe ChannelGroup do
  subject { FactoryGirl.build(:channel_group) }
  it { should be_valid }
end

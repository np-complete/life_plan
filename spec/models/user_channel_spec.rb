require 'spec_helper'

describe UserChannel do
  subject { FactoryGirl.build(:user_channel) }
  it { should be_valid }
end

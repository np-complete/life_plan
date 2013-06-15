require 'spec_helper'

describe Channel do
  subject { FactoryGirl.build(:channel) }
  it { should be_valid }
end

require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }
  it { should be_valid }
end

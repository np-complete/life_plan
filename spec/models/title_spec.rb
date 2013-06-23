require 'spec_helper'

describe Title do
  subject { @title = FactoryGirl.build(:title) }
  it { should be_valid }
end

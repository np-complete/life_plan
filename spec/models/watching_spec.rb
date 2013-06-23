require 'spec_helper'

describe Watching do
  subject { FactoryGirl.build(:watching) }
  it { should be_valid }
end

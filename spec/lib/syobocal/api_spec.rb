require 'spec_helper'
require 'syobocal'

describe Syobocal::API do

  describe :channels do
    subject { @channels }
    before { @channels = Syobocal::API.channels }
    it { should be_a Array }
    it 'not contains nil' do
      expect(@channels.any?{|x| x[:group_name].nil? }).to be_false
    end
    describe 'a channel' do
      subject { Syobocal::API.channels.first }
      [:group_name, :group_id, :name, :channel_id].each do |key|
        it "should have #{key}" do
          expect(subject.keys).to include(key)
        end
      end
    end
  end

  describe :programs do
    subject { Syobocal::API.programs }
    it { should be_a Array }
  end
end

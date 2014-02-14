require 'spec_helper'
require 'syobocal'

describe Syobocal::API do

  describe :channels do
    let(:channels) { Syobocal::API.channels }
    it { expect(channels).to be_a Array }
    it 'not contains nil' do
      expect(channels.any?{|x| x[:group_name].nil? }).to be_false
    end
    describe 'a channel' do
      let(:channel) { channels.first }
      [:group_name, :group_id, :name, :channel_id].each do |key|
        it "should have #{key}" do
          expect(channel).to have_key key
        end
      end
    end
  end

  describe :programs do
    let(:programs) { Syobocal::API.programs }
    describe :titles do
      it 'create titles' do
        expect{ Syobocal::API.programs }.to change { Title.count }
      end

      it 'update title' do
        Syobocal::API.programs
        title = Title.first
        title.update_attributes(:name => 'foo')
        Syobocal::API.programs
        expect(Title.first.name).not_to eq title.name
      end
    end
    it { expect(programs).to be_a Array }
  end
end

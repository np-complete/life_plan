require 'spec_helper'

describe Channel do
  describe :factory do
    it { expect(build(:channel)).to be_valid }
  end

  describe :fetch_all do
    let(:channels) {
      [
        { group_id: 1, group_name: 'group_1', channel_id: 1, name: 'channel_1' },
        { group_id: 1, group_name: 'group_1', channel_id: 2, name: 'channel_2' },
        { group_id: 2, group_name: 'group_2', channel_id: 3, name: 'channel_3' },
        { group_id: 3, group_name: 'group_3', channel_id: 4, name: 'channel_4' }
      ]
    }
    before do
      Channel.destroy_all
      ChannelGroup.destroy_all
      Syobocal::API.stub(:channels).and_return(channels)
    end
    after do
      Channel.destroy_all
      ChannelGroup.destroy_all
    end
    it 'fetch and create group' do
      expect {
        Channel.fetch_all
      }.to change { ChannelGroup.count }.by(3)
    end

    it 'fetch and create channel' do
      expect {
        Channel.fetch_all
      }.to change { Channel.count }.by(4)
      expect(Channel.all.map(&:id)).to eq [1, 2, 3, 4]
    end
  end
end

require 'rails_helper'

describe Api::V1::ProgramsController do
  let(:user) { create :user }
  let(:token) { double accessible?: true, resource_owner_id: user.id, acceptable?: true }
  let(:titles) { create_list :title, 5 }
  let(:channels) { create_list :channel, 10 }

  def program_stub(opt = {})
    opt = { no: 1, subtitle: 'subtitle', start_at: Time.zone.at(1) }.merge(opt)
    opt[:title_id] = opt[:title].id if opt[:title]
    opt[:channel_id] = opt[:channel].id if opt[:channel]
    Program.new(opt)
  end

  describe 'GET index' do
    it 'respond watching programs' do
      allow(controller).to receive(:doorkeeper_token) { token }
      expect(Program).to receive(:today).and_return([
                                                      program_stub(title: titles.first, channel: channels.first),
                                                      program_stub(title: titles.last,  channel: channels.first),
                                                      program_stub(title: titles.first, channel: channels.last),
                                                      program_stub(title: titles.last,  channel: channels.last)
                                                    ])
      create :watching, user: user, title: titles.first
      create :user_channel, user: user, channel: channels.first
      get :index, format: :json
      json = JSON.parse response.body
      expect(json).to eq [{
        channel: channels.first.name,
        title: titles.first.name,
        no: 1,
        subtitle: 'subtitle',
        start_at: 1
      }.stringify_keys]
    end
  end
end

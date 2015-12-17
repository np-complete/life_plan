require 'rails_helper'

RSpec.describe Program, type: :model do
  describe '#start_at=' do
    let(:program) { Program.new }
    let(:str) { '2015/01/01 20:00:00' }
    let(:num) { expected.to_i }
    let(:expected) { ActiveSupport::TimeZone['Tokyo'].parse(str) }

    it do
      expect { program.start_at = str }.to change { program.start_at }.to(expected)
    end
    it do
      expect { program.start_at = num }.to change { program.start_at }.to(expected)
    end
  end
end

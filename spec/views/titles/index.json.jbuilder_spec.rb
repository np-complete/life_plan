require 'rails_helper'

describe 'titles/index.json.jbuilder' do
  before(:each) do
    @titles = assign(:titles, Kaminari.paginate_array(FactoryGirl.create_list(:title, 4)).page(1))
    assign(:watching_ids, [@titles.first.id])
  end
  it 'render json' do
    render
    titles = JSON.parse(response).map { |x| OpenStruct.new(x) }
    expect(titles.count).to eq 4
    expect(titles.map(&:name)).to eq @titles.map(&:name)
    expect(titles.map(&:watch?)).to eq [true, false, false, false]
  end
end

require 'rails_helper'

describe 'titles/index.json.jbuilder' do
  before(:each) do
    @titles = assign(:titles, Kaminari.paginate_array(FactoryGirl.create_list(:title, 4)).page(1))
    assign(:watching_ids, [@titles.first.id])
    @options = assign(:options, page: 1)
  end
  it 'render json' do
    render
    json = MultiJson.decode response, symbolize_keys: true
    expect(json[:pages]).to eq 1
    expect(json[:options]).to eq page: 1
    titles = json[:titles]
    expect(titles.count).to eq 4
    expect(titles.first[:id]).to eq @titles.first.id
    expect(titles.first[:name]).to eq @titles.first.name
    expect(titles.map { |t| t[:watch] }).to eq [true, false, false, false]
  end
end

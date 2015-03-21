require 'rails_helper'

describe 'titles/index.json.jbuilder' do
  before(:each) do
    @titles = assign(:titles, Kaminari.paginate_array(FactoryGirl.create_list(:title, 4)).page(1))
    assign(:watching_ids, [@titles.first.id])
  end
  it 'render json' do
    render
    titles = JSON.parse(response)
    expect(titles.count).to eq 4
    expect(titles.first['id']).to eq @titles.first.id
    expect(titles.first['name']).to eq @titles.first.name
    expect(titles.map { |t| t['watch'] }).to eq [true, false, false, false]
  end
end

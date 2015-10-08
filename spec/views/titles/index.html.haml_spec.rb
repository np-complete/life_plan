require 'rails_helper'

describe 'titles/index.html.haml' do
  before(:each) do
    assign(:__react_component_helper, controller.setup_react_component_helper)
    assign(:titles, Kaminari.paginate_array(FactoryGirl.create_list(:title, 4)).page(1))
    assign(:watching_ids, [])
  end

  it 'renders a list of titles' do
    render
  end
end

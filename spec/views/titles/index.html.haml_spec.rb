require 'spec_helper'

describe "titles/index" do
  before(:each) do
    assign(:titles, Kaminari.paginate_array(FactoryGirl.create_list(:title, 4)).page(1))
    assign(:watching_ids, [])
  end

  it "renders a list of titles" do
    render
  end
end

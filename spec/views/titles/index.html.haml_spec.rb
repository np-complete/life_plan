require 'spec_helper'

describe "titles/index" do
  before(:each) do
    assign(:titles, Kaminari.paginate_array(FactoryGirl.create_list(:title, 4)).page(1))
  end

  it "renders a list of titles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

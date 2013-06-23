require 'spec_helper'

describe "Titles" do
  describe "GET /titles" do
    it "works! (now write some real specs)" do
      get titles_path
      response.status.should be(200)
    end
  end
end

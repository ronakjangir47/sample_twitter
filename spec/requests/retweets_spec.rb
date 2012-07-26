require 'spec_helper'

describe "Retweets" do
  describe "GET /retweets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get retweets_path
      response.status.should be(200)
    end
  end
end

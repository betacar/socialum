require 'spec_helper'

describe "Descargas" do
  describe "GET /descargas" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get descargas_path
      response.status.should be(200)
    end
  end
end

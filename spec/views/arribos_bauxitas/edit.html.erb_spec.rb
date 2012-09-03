require 'spec_helper'

describe "arribos_bauxitas/edit" do
  before(:each) do
    @arribo_bauxita = assign(:arribo_bauxita, stub_model(ArriboBauxita))
  end

  it "renders the edit arribo_bauxita form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => arribos_bauxitas_path(@arribo_bauxita), :method => "post" do
    end
  end
end

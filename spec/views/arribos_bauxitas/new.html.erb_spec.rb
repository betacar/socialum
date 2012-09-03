require 'spec_helper'

describe "arribos_bauxitas/new" do
  before(:each) do
    assign(:arribo_bauxita, stub_model(ArriboBauxita).as_new_record)
  end

  it "renders new arribo_bauxita form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => arribos_bauxitas_path, :method => "post" do
    end
  end
end

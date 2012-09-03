require 'spec_helper'

describe "descargas/new" do
  before(:each) do
    assign(:descarga, stub_model(Descarga).as_new_record)
  end

  it "renders new descarga form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => descargas_path, :method => "post" do
    end
  end
end

require 'spec_helper'

describe "descargas/edit" do
  before(:each) do
    @descarga = assign(:descarga, stub_model(Descarga))
  end

  it "renders the edit descarga form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => descargas_path(@descarga), :method => "post" do
    end
  end
end

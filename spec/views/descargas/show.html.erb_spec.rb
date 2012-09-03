require 'spec_helper'

describe "descargas/show" do
  before(:each) do
    @descarga = assign(:descarga, stub_model(Descarga))
  end

  it "renders attributes in <p>" do
    render
  end
end

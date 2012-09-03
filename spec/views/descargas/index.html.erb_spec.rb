require 'spec_helper'

describe "descargas/index" do
  before(:each) do
    assign(:descargas, [
      stub_model(Descarga),
      stub_model(Descarga)
    ])
  end

  it "renders a list of descargas" do
    render
  end
end

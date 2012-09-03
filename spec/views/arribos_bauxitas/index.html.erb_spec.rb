require 'spec_helper'

describe "arribos_bauxitas/index" do
  before(:each) do
    assign(:arribos_bauxitas, [
      stub_model(ArriboBauxita),
      stub_model(ArriboBauxita)
    ])
  end

  it "renders a list of arribos_bauxitas" do
    render
  end
end

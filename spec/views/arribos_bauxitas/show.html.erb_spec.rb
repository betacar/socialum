require 'spec_helper'

describe "arribos_bauxitas/show" do
  before(:each) do
    @arribo_bauxita = assign(:arribo_bauxita, stub_model(ArriboBauxita))
  end

  it "renders attributes in <p>" do
    render
  end
end

require "spec_helper"

describe ArribosBauxitasController do
  describe "routing" do

    it "routes to #index" do
      get("/arribos_bauxitas").should route_to("arribos_bauxitas#index")
    end

    it "routes to #new" do
      get("/arribos_bauxitas/new").should route_to("arribos_bauxitas#new")
    end

    it "routes to #show" do
      get("/arribos_bauxitas/1").should route_to("arribos_bauxitas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/arribos_bauxitas/1/edit").should route_to("arribos_bauxitas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/arribos_bauxitas").should route_to("arribos_bauxitas#create")
    end

    it "routes to #update" do
      put("/arribos_bauxitas/1").should route_to("arribos_bauxitas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/arribos_bauxitas/1").should route_to("arribos_bauxitas#destroy", :id => "1")
    end

  end
end

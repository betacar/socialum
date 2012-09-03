require "spec_helper"

describe DescargasController do
  describe "routing" do

    it "routes to #index" do
      get("/descargas").should route_to("descargas#index")
    end

    it "routes to #new" do
      get("/descargas/new").should route_to("descargas#new")
    end

    it "routes to #show" do
      get("/descargas/1").should route_to("descargas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/descargas/1/edit").should route_to("descargas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/descargas").should route_to("descargas#create")
    end

    it "routes to #update" do
      put("/descargas/1").should route_to("descargas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/descargas/1").should route_to("descargas#destroy", :id => "1")
    end

  end
end

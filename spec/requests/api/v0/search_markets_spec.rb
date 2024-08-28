require 'rails_helper'

RSpec.describe "Market Money API" do
  before :each do
    @market1 = Market.create(:market, city: 'Albuquerque', state: 'New Mexico', name: 'Nob Hill Growers Market' )
    @market2 = Market.create(:market, city: 'Santa Fe', state: 'New Mexico', name: 'Santa Fe Market'  )

  describe "GET /api/v0/markets/search" do
    context "when valid parameters are present" do
      it "returns correct market" do
        
        get "/api/v0/markets/search", params{city: 'Albuquerque', state: 'New Mexico', name: 'Nob Hill Growers Market'}

        market = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)

        expect(json["data"].length).to eq(1)

        expect(json["data"].first.["attributes"]["name"]).to eq("Nob Hill Growers Market")
        
      end

      it "returns an empty array when there are no markets" do
        get "/api/v0/markets/search", params{city: 'ASDF', state: 'ASDF', name: 'ASDF'}

        expect(response).to have_http_status(:ok)

        expect(json["data"]).to be_empty

      end
    end

    context "when invalid parameters are sent" do
      it "cannot get a market when searched by city (422 error)"
        get "/api/v0/markets/search", params{city: 'Albuquerque' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["errors"].first["detail"]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
      end

      it "returns a 422 error when searching by only city and name without state"
        get "/api/v0/markets/search", params{city: 'Albuquerque', name: 'Nob Hill Growers Market' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["errors"].first["detail"]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
      end
    end
  end
end
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
    end

    context "when invalid parameters are sent" do
      it "cannot get a market when searched by city or name and city"
        get "/api/v0/markets/search"

        expect(response).to have_http_status(:not_found)
        expect(response.status).to eq(422)
        
        market_response = JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
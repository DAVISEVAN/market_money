require 'rails_helper'  
RSpec.describe "Markets API", type: :request do
  describe "GET /api/v0/markets" do
    it "returns all markets with their vendor count" do
      market1 = create(:market)
      market2 = create(:market)

      create_list(:vendor, 3, markets: [market1])
      create_list(:vendor, 5, markets: [market2])

      get "/api/v0/markets"

      expect(response).to have_http_status(:success)

      # Parse the response body directly as an array of hashes
      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets.count).to eq(2)

      # Access the vendor_count for each market
      expect(markets[0][:vendor_count]).to eq(3)
      expect(markets[1][:vendor_count]).to eq(5)
    end
  end
end

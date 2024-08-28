require 'rails_helper'

RSpec.describe "Market Money API" do
  before :each do
    @market1 = Market.create(:market, city: 'Albuquerque', state: 'New Mexico', name: 'Nob Hill Growers Market' )
    @market2 = Market.create(:market, city: 'Santa Fe', state: 'New Mexico', name: 'Santa Fe Market'  )

  describe "GET /api/v0/markets/search" do
    context "when valid parameters are present" do
      it "returns correct market" do
        
        get "/api/v0/markets/search"

        

      end
    end

    context "when invalid parameters are sent" do
      it "cannot get a market when searched by city or name and city"
      end
    end
  end
end
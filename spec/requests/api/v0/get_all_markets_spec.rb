require 'rails_helper'

RSpec.describe 'Markets API', type: :request do
  describe 'GET /api/v0/markets' do
    let!(:market1) { create(:market, name: "14&U Farmers' Market") }
    let!(:market2) { create(:market, name: "2nd Street Farmers' Market") }
    let!(:vendor1) { create(:vendor) }
    let!(:vendor2) { create(:vendor) }

    before do
      market1.vendors << vendor1
      market2.vendors << vendor1
      market2.vendors << vendor2
    end

    it 'returns all markets with their vendor count' do
      get '/api/v0/markets'

      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data].count).to eq(2)
      expect(parsed_response[:data].first[:attributes][:name]).to eq("14&U Farmers' Market")
      expect(parsed_response[:data].first[:attributes][:vendor_count]).to eq(1)
      expect(parsed_response[:data].last[:attributes][:vendor_count]).to eq(2)
    end
  end
end
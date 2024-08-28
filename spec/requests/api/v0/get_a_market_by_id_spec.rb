require 'rails_helper'

RSpec.describe 'Markets API', type: :request do
  describe 'GET /api/v0/markets/:id' do
    let!(:market) { create(:market, name: "2nd Street Farmers' Market") }
    let!(:vendors) { create_list(:vendor, 35, markets: [market]) }

    context 'when the market exists' do
      it 'returns the market' do
        get "/api/v0/markets/#{market.id}"

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:data][:id]).to eq(market.id.to_s)
        expect(json_response[:data][:attributes][:name]).to eq(market.name)
        expect(json_response[:data][:attributes][:vendor_count]).to eq(35)
      end
    end

    context 'when the market does not exist' do
      it 'returns a 404 error' do
        get "/api/v0/markets/999999"

        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=999999")
      end
    end
  end
end
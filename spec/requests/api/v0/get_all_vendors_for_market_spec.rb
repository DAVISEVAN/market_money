require 'rails_helper'

RSpec.describe 'Market Vendors API', type: :request do
  describe 'GET /api/v0/markets/:market_id/vendors' do
    let!(:market) { create(:market) }
    let!(:vendors) { create_list(:vendor, 3, markets: [market]) }

    context 'when the market exists' do
      it 'returns the vendors for the market' do
        get "/api/v0/markets/#{market.id}/vendors"

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:data].size).to eq(3)
        
        vendors.each_with_index do |vendor, index|
          expect(json_response[:data][index][:attributes][:name]).to eq(vendor.name)
          expect(json_response[:data][index][:attributes][:description]).to eq(vendor.description)
          expect(json_response[:data][index][:attributes][:contact_name]).to eq(vendor.contact_name)
          expect(json_response[:data][index][:attributes][:contact_phone]).to eq(vendor.contact_phone)
          expect(json_response[:data][index][:attributes][:credit_accepted]).to eq(vendor.credit_accepted)
        end
      end
    end

    context 'when the market does not exist' do
      it 'returns a 404 status code' do
        get '/api/v0/markets/123123123/vendors'

        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=123123123")
      end
    end
  end
end
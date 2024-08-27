require 'rails_helper'

RSpec.describe "Market's Vendors API", type: :request do
  describe 'GET /api/v0/markets/:market_id/vendors' do
    let!(:market) { create(:market) }
    let!(:vendors) { create_list(:vendor, 3, markets: [market]) }

    context 'when the market exists' do
      before { get "/api/v0/markets/#{market.id}/vendors" }

      it 'returns the vendors' do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(3)
      end

      it 'returns the correct vendor attributes' do
        json_response = JSON.parse(response.body)

        json_response.each_with_index do |vendor_json, index|
          vendor = vendors[index]
          expect(vendor_json['attributes']['name']).to eq(vendor.name)
          expect(vendor_json['attributes']['description']).to eq(vendor.description)
          expect(vendor_json['attributes']['contact_name']).to eq(vendor.contact_name)
          expect(vendor_json['attributes']['contact_phone']).to eq(vendor.contact_phone)
          expect(vendor_json['attributes']['credit_accepted']).to eq(vendor.credit_accepted)
        end
      end
    end

    context 'when the market does not exist' do
      before { get "/api/v0/markets/999999/vendors" }

      it 'returns a 404 not found status' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['errors'].first['detail']).to match(/Couldn't find Market with 'id'=/)
      end
    end
  end
end

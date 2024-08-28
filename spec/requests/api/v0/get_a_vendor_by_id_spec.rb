require 'rails_helper'

RSpec.describe 'Vendor API', type: :request do
  describe 'GET /api/v0/vendors/:id' do
    context 'when the vendor exists' do
      let!(:vendor) { create(:vendor, name: "Orange County Olive Oil", contact_name: "Syble Hamill", credit_accepted: false) }

      it 'returns the vendor' do
        get "/api/v0/vendors/#{vendor.id}", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response[:data][:id]).to eq(vendor.id.to_s)
        expect(json_response[:data][:type]).to eq('vendor')
        expect(json_response[:data][:attributes][:name]).to eq("Orange County Olive Oil")
        expect(json_response[:data][:attributes][:contact_name]).to eq("Syble Hamill")
        expect(json_response[:data][:attributes][:credit_accepted]).to eq(false)
      end
    end

    context 'when the vendor does not exist' do
      it 'returns a 404 status with an error message' do
        get "/api/v0/vendors/123123123123", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=123123123123")
      end
    end
  end
end
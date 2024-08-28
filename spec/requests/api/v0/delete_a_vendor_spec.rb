require 'rails_helper'

RSpec.describe 'Vendors API', type: :request do
  describe 'DELETE /api/v0/vendors/:id' do
    let!(:vendor) { create(:vendor) }

    context 'when the vendor exists' do
      it 'deletes the vendor and returns a 204 status' do
        expect {
          delete "/api/v0/vendors/#{vendor.id}", as: :json
        }.to change(Vendor, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the vendor does not exist' do
      it 'returns a 404 status with an error message' do
        delete "/api/v0/vendors/123123123", as: :json

        expect(response).to have_http_status(:not_found)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors].first[:detail]).to include("Couldn't find Vendor with 'id'=123123123")
      end
    end
  end
end
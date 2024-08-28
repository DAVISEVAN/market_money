require 'rails_helper'

RSpec.describe 'Vendors API', type: :request do
  describe 'PATCH /api/v0/vendors/:id' do
    let!(:vendor) { create(:vendor, name: "Buzzy Bees", contact_name: "Berly Couwer", contact_phone: "8389928383", credit_accepted: false) }
    let(:valid_attributes) { { contact_name: "Kimberly Couwer", credit_accepted: true } }
    let(:invalid_attributes) { { contact_name: "" } }

    context 'when the vendor exists' do
      context 'with valid attributes' do
        it 'updates the vendor and returns the updated vendor' do
          patch "/api/v0/vendors/#{vendor.id}", params: { vendor: valid_attributes }, as: :json

          expect(response).to have_http_status(:ok)
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response[:data][:attributes][:contact_name]).to eq("Kimberly Couwer")
          expect(parsed_response[:data][:attributes][:credit_accepted]).to be(true)
        end
      end

      context 'with invalid attributes' do
        it 'returns a 400 status with an error message' do
          patch "/api/v0/vendors/#{vendor.id}", params: { vendor: invalid_attributes }, as: :json

          expect(response).to have_http_status(:bad_request)
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response[:errors].first[:detail]).to include("Contact name can't be blank")
        end
      end
    end

    context 'when the vendor does not exist' do
      it 'returns a 404 status with an error message' do
        patch "/api/v0/vendors/123123123", params: { vendor: valid_attributes }, as: :json

        expect(response).to have_http_status(:not_found)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors].first[:detail]).to include("Couldn't find Vendor with 'id'=123123123")
      end
    end
  end
end
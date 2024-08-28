require 'rails_helper'

RSpec.describe 'Vendors API', type: :request do
  describe 'POST /api/v0/vendors' do
    let(:valid_attributes) do
      {
        name: "Buzzy Bees",
        description: "local honey and wax products",
        contact_name: "Berly Couwer",
        contact_phone: "8389928383",
        credit_accepted: false
      }
    end

    let(:invalid_attributes) do
      {
        name: "Buzzy Bees",
        description: "local honey and wax products",
        credit_accepted: false
      }
    end

    context 'when the request is valid' do
      it 'creates a vendor' do
        post '/api/v0/vendors', params: { vendor: valid_attributes }, as: :json

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response[:data][:attributes][:name]).to eq("Buzzy Bees")
        expect(json_response[:data][:attributes][:contact_name]).to eq("Berly Couwer")
        expect(json_response[:data][:attributes][:credit_accepted]).to eq(false)
      end
    end

    context 'when the request is invalid' do
      it 'returns a 400 status with an error message' do
        post '/api/v0/vendors', params: { vendor: invalid_attributes }, as: :json

        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body, symbolize_names: true)

        error_messages = json_response[:errors].map { |error| error[:detail] }
        expect(error_messages).to include("Contact name can't be blank")
        expect(error_messages).to include("Contact phone can't be blank")
      end
    end
  end
end
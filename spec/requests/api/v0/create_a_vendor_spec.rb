require 'rails_helper'

RSpec.describe "Vendors API", type: :request do
  describe 'POST /api/v0/vendors' do
    context 'when the request is valid' do
      let(:valid_attributes) do
        {
          name: "Buzzy Bees",
          description: "local honey and wax products",
          contact_name: "Berly Couwer",
          contact_phone: "8389928383",
          credit_accepted: false
        }
      end

      it 'creates a vendor' do
        post '/api/v0/vendors', params: { vendor: valid_attributes }, as: :json

        expect(response).to have_http_status(:created)

        
        json_response = JSON.parse(response.body, symbolize_names: true)

        
        expect(json_response[:attributes][:name]).to eq("Buzzy Bees")
        expect(json_response[:attributes][:description]).to eq("local honey and wax products")
        expect(json_response[:attributes][:contact_name]).to eq("Berly Couwer")
        expect(json_response[:attributes][:contact_phone]).to eq("8389928383")
        expect(json_response[:attributes][:credit_accepted]).to eq(false)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe "Market Money API" do
  it "can get one market by its id" do
    id = create(:market).id
    
    vendor = create(:vendor)

    market_vendors = MarketVendor.create(market: id, vendor: vendor)


    get "/api/v0/markets/#{id}"

    market = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(market).to have_key(:id)
    expect(market[:id]).to eq(id)

    expect(market).to have_key(:name)
    expect(market[:name]).to be_a(String)

    expect(market).to have_key(:street)
    expect(market[:street]).to be_a(String)

    expect(market).to have_key(:city)
    expect(market[:city]).to be_a(String)

    expect(market).to have_key(:county)
    expect(market[:county]).to be_a(String)

    expect(market).to have_key(:state)
    expect(market[:state]).to be_a(String)
    
    expect(market).to have_key(:zip)
    expect(market[:zip]).to be_a(String)

    expect(market).to have_key(:lat)
    expect(market[:lat]).to be_a(String)

    expect(market).to have_key(:lon)
    expect(market[:lon]).to be_a(String)
    
    expect(market).to have_key(:vendor_count)
    expect(market[:vendor_count]).to eq(1)
  end
end
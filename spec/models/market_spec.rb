require 'rails_helper'

RSpec.describe Market, type: :model do
  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'instance methods' do
    describe '#vendor_count' do
      it 'returns the number of vendors associated with the market' do
        market = create(:market)
        create_list(:vendor, 3, markets: [market])

        expect(market.vendors.count).to eq(3)
      end
    end
  end
end
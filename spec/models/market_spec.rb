require 'rails_helper'

RSpec.describe Market, type: :model do
  describe 'instance methods' do
    describe '#vendor_count' do
      it 'returns the number of vendors associated with the market' do
        market = create(:market)
        create_list(:vendor, 3, markets: [market])
        
        expect(market.vendor_count).to eq(3)
      end
    end
  end
end

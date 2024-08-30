require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:markets).through(:market_vendors) }
  end

  describe 'instance_methods' do
    it "returns an error if no credit card number is given" do
      vendor = Vendor.new(credit_accepted: nil)

      expect(vendor).not_to be_valid 
      expect(vendor.errors[:credit_accepted]).to include("can't be blank")
    end
  end
end
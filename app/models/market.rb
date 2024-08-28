class Market < ApplicationRecord
  has_many :market_vendors, dependent: :destroy
  has_many :vendors, through: :market_vendors

  def vendor_count
    vendors.count
  end
end

class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  validates :name, :description, :contact_name, :contact_phone, presence: true
  validate :credit_accepted_present

  private

  def credit_accepted_present
    if credit_accepted.nil?
      errors.add(:credit_accepted, "must be true or false")
    end
  end
end


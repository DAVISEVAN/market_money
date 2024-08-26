FactoryBot.define do
  factory :market do
    name { Faker::Company.name }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Address.county }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude.to_s }
    lon { Faker::Address.longitude.to_s  }
  end
end
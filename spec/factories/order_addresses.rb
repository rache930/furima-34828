FactoryBot.define do
  factory :order_address do
    token {"tok_abcdefghijk00000000000000000"}  
    postal_code { '123-4567' }
    prefecture_id { rand(1..47).to_s }
    city { '東京' }
    building_name { '東京ハイツ'}
    house_number { '1-1' }
    phone_number { rand(1_000_000_000..99_999_999_999).to_s }
  end
end

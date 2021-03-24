FactoryBot.define do
  factory :item do
    name {Faker::FunnyName.name}
    text {Faker::Lorem.sentence}
    category_id {rand(2..11).to_s}
    condition_id {rand(2..7).to_s}
    shipping_fee_id {rand(2..3).to_s}
    prefecture_id {rand(1..47).to_s}
    shipping_date_id {rand(2..4).to_s}
    price {rand(300..9999999).to_s}

    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
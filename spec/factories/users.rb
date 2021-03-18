FactoryBot.define do
  factory :user do
    last_name { '鈴木' }
    first_name { '太郎' }
    last_name_reading { 'スズキ' }
    first_name_reading { 'タロウ' }
    birth_date { '2000-01-01' }
    nickname { 'suzuki' }
    email { 'test@example' }
    password { 'test1234' }
    password_confirmation { password }
  end
end

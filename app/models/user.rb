class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  valid_password = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i

  with_options presence: true do
    validates :password, on: :create, format: { with: valid_password, message: 'is invalid. Input half-width characters.' }
    validates :nickname
    validates :birth_date
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' }
      validates :last_name_reading
      validates :first_name_reading
    end
  end
end

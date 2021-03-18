class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  valid_password = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i

  with_options presence: true do
    validates :password, on: :create, format: { with: valid_password, message: 'is invalid. Input half-width characters.' }
    validates :nickname
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :last_name_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' }
    validates :first_name_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' }
    validates :birth_date
  end
end

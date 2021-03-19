class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image

  half_num = /\A[0-9]+\z/
  jp_yen = greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999

  with_options presence: true do
    validates :name
    validates :text
    with_options  numericality: { other_than: 1 } do
      validates :category_id, 
      validates :condition_id
      validates :shipping_fee_id
      validates :prefecture_id
      validates :shipping_date_id
    end
    validates :price, format: {with: half_num }, numericality: {jp_yen}
  end
end

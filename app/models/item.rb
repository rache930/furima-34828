class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :text
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :shipping_fee_id
      validates :shipping_date_id
    end
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
end

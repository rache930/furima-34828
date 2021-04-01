class ItemsTag
  
  include ActiveModel::Model
  attr_accessor :image, :name, :text, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                :shipping_date_id, :price, :user_id, :tag_name

  with_options presence: true do
    validates :image
    validates :name
    validates :text
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :shipping_fee_id
      validates :shipping_date_id
    end
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  def save
    item = Item.create(name: name, text: text, category_id: category_id, condition_id: condition_id,
                       shipping_fee_id: shipping_fee_id, prefecture_id: prefecture_id,
                       shipping_date_id: shipping_date_id, price: price, user_id: user_id, image: image)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end  
end
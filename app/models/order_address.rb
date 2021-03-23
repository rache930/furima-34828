class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number, :user_id, :item_id

  
  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture, numericality: {other_than: 0, message: "Select"}, presence: false
    validates :city
    validates :house_number
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "is invalid. Exclude hyphen(-)"}
  end
   

  def save
    order = Order.create(user_id: current_user.id, item_id: params[:item_id])
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end  
end
class OrdersController < ApplicationController
  before_action :item_find, only: [:index, :create]
  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end  

  private
  
  def item_find
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end  
end

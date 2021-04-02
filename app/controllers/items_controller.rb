class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :item_find, only: [:show, :edit, :update]
  before_action :look_item, only: [:index, :look]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = ItemsTag.new
  end

  def create
    @item = ItemsTag.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  def search
    return nil if params[:keyword] == ""
     tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def look
    @results = @p.result
    @items = Item.includes(:user).order('created_at DESC')
     
  end

  private

  def item_find
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:items_tag).permit(:image, :name, :text, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                      :shipping_date_id, :price, :tag_name).merge(user_id: current_user.id)
  end

  def move_to_index
    item = Item.find(params[:id])
    if current_user.id == item.user_id && item.order.nil?
      nil
    else
      redirect_to action: :index
    end
  end

  def look_item
    @p = Item.ransack(params[:q])
  end

end

class ItemsController < ApplicationController
  before_action :move_to_session, only: [:new]
  def index
    
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def move_to_session
    unless user_signed_in?
      redirect_to  user_session_path
    end
  end

  def item_params
    params.require(:item)
    .permit(
      :item_name,
      :description,
      :category_id,
      :status_id,
      :which_delivery_fee_id,
      :prefecture_id,
      :days_to_delivery_id,
      :price,
      :image
    )
    .merge(user_id: current_user.id)
  end
end

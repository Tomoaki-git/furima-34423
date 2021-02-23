class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :DESC)
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to action: :show
    else
      render :edit
    end
  end

  private

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

  def move_to_index
    @item = Item.find(params[:id])
    unless current_user == @item.user
      redirect_to action: :index
    end
  end
end

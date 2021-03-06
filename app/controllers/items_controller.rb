class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
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
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to action: :index
  end

  private

  def find_item
    @item = Item.find(params[:id])
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

  def move_to_index
    unless @item.buyer.nil? && current_user == @item.user
      redirect_to action: :index
    end
  end
end

class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :judge_user, only: [:index, :update]
  before_action :judge_soldout, only: [:index, :create]

  def index
    @buyer_shipping_add = BuyerShippingAdd.new
  end


  def create
    @buyer_shipping_add = BuyerShippingAdd.new(buyer_params)
    if @buyer_shipping_add.valid?
      pay_item
      @buyer_shipping_add.save
      return redirect_to root_path
    else
      render :index
    end
  end
  
  private

  def judge_user
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def buyer_params
    params
    .require(:buyer_shipping_add)
    .permit(
      :postal_code,
      :prefecture_id,
      :municipalities,
      :address, :building,
      :tel
    )
    .merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end

  def judge_soldout
    if @item.buyer.present?
      redirect_to root_path
    end
  end

end
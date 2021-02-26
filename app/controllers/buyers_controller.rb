class BuyersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @buyer_shipping_add = BuyerShippingAdd.new
  end

  def create
    @buyer_shipping_add = BuyerShippingAdd.new(buyer_params)
    if @buyer_shipping_add.valid?
      pay_item
      @buyer_shipping_add.save
      return redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end
  
  private

  def buyer_params
    binding.pry
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
    item = Item.find(params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end

end
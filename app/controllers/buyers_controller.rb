class BuyersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @buyer_shipping_add = BuyerShippingAdd.new
  end

  def create
    @buyer_shipping_add = BuyerShippingAdd.new(buyer_params)
    if @buyer_shipping_add.valid?
      @buyer_shipping_add.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end
  
  private

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
    .merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
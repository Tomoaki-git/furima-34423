class BuyersController < ApplicationController
  def index
    @item = Buyer.Item.find(params[:id])
  end
end

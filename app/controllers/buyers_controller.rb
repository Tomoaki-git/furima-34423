class BuyersController < ApplicationController
  def index
    @buyer = Buyer.new
  end
end

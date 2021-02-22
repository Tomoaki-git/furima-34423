class ItemsController < ApplicationController
  before_action :move_to_session, only: [:new]
  def index
    
  end

  def new
      @item = Item.new
  end

  def create
    
  end

  private

  def move_to_session
    unless user_signed_in?
      redirect_to  user_session_path
    end
  end

  def item_params
    params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
  end
end

class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item_name
    validates :description
    validates :category_id
    validates :status_id
    validates :which_delivery_fee_id
    validates :prefecture_id
    validates :days_to_delivery_id

    with_options numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999} do
      validates :price
    end
  end
end

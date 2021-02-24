class Item < ApplicationRecord
  belongs_to :user
  has_one :buyer
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :which_delivery_fee
  belongs_to :prefecture
  belongs_to :days_to_delivery


  with_options presence: true do
    validates :image
    validates :item_name
    validates :description

    with_options numericality: { other_than: 0 } do
      validates :category_id
      validates :status_id
      validates :which_delivery_fee_id
      validates :prefecture_id
      validates :days_to_delivery_id
    end

    with_options numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}, format:{ with: /\A[0-9]+\z/ } do
      validates :price
    end
  end
end

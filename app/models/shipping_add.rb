class ShippingAdd < ApplicationRecord
  belongs_to :buyer

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :municipalities
    validates :address
    validates :tel

    with_options foreign_key: true do
      validates :buyer
    end
  end
end

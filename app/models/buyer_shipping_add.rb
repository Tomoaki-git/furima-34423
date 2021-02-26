class BuyerShippingAdd
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :address, :building, :tel, :token

  with_options presence: true do
    with_options format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"} do
      validates :postal_code
    end

    validates :user_id
    validates :item_id
    validates :municipalities
    validates :address

    with_options format: {with: /\A[0-9]+\z/, lengh: {maximum: 11}} do
      validates :tel
    end

    validates :token

    with_options numericality: { other_than: 0, message: "can't be blank" } do
      validates :prefecture_id
    end
  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    ShippingAdd.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address,building: building, tel: tel, buyer_id: buyer.id)
  end
end
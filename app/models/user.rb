class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    with_options format:{ with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/ } do
      validates :password
      validates :password_confirmation
    end

    validates :nickname

    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/} do
      validates :family_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/} do
      validates :family_name_kana
      validates :first_name_kana
    end

    validates :birthday
  end
end

require 'rails_helper'

RSpec.describe BuyerShippingAdd, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.jpg')
    @item.save
    @user = FactoryBot.create(:user)
    @order = FactoryBot.build(:buyer_shipping_add)
    @order.user_id = @user.id
    @order.item_id = @item.id
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it '全ての情報が正常に入力できている場合は登録できる' do
        expect(@order).to be_valid
        sleep 0.1
      end

      it '[building]は空でも保存できる' do
        @order.building = nil
        @order.valid?
        expect(@order).to be_valid
        sleep 0.1
      end
    end

    context '購入できない場合' do
      it '[token]が空だと保存できない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
        sleep 0.1
      end
    
      it '[postal_code]が空だと保存できない' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
        sleep 0.1
      end

      it '[postal_code]はハイフンがないと登録できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")

      end

      it '[postal_code]が4桁-3桁だと登録できない' do
        @order.postal_code = '1234-567'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
        sleep 0.1
      end

      it '[prefecture_id]が0の場合は投稿できない' do
        @order.prefecture_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
        sleep 0.1
      end

      it '[municipalities]が空だと保存できない' do
        @order.municipalities = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipalities can't be blank")
        sleep 0.1
      end

      it '[address]が空だと保存できない' do
        @order.address = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
        sleep 0.1
      end

      it '[tel]が空だと保存できない' do
        @order.tel = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel can't be blank")
        sleep 0.1
      end

      it '[tel]は11桁以下でないと登録できない' do
        @order.tel = '111111111111'
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel is invalid")
        sleep 0.1
      end

      it '[tel]は英数混合だと登録できない' do
        @order.tel = 'abcde12345'
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel is invalid")
        sleep 0.1
      end
    end
  end
end

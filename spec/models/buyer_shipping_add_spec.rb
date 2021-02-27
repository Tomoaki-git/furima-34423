require 'rails_helper'

RSpec.describe BuyerShippingAdd, type: :model do
  before do
    @order = FactoryBot.build(:buyer_shipping_add)
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it '全ての情報が正常に入力できている場合は登録できる' do
        expect(@order).to be_valid
      end
    end

    context '購入できない場合(:token)' do
      it '空だと保存できない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
    end
    
    context '購入できない場合(:postal_code)' do
      it '空だと保存できない' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'ハイフンがないと登録できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it '4桁-3桁だと登録できない' do
        @order.postal_code = '1234-567'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
    end

    context '購入できない場合(:prefecture_id)' do
      it '「prefecture_id」が0の場合は投稿できない' do
        @order.prefecture_id = '0'
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
    end

    context '購入できない場合(:municipalities)' do
      it '空だと保存できない' do
        @order.municipalities = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipalities can't be blank")
      end
    end

    context '購入できない場合(:address)' do
      it '空だと保存できない' do
        @order.address = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
    end

    context '購入できない場合(:tel)' do
      it '空だと保存できない' do
        @order.tel = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel can't be blank")
      end

      it '11桁以下でないと登録できない' do
        @order.tel = '111111111111'
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel is invalid")
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.jpg')
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it '全ての情報が正常に入力できている場合は登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合(:image)' do
      it '商品画像を1枚ないと投稿できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end

    context '出品できない場合(:item_name)' do
      it '商品名がないと投稿できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
    end

    context '出品できない場合(:description)' do
      it '商品の説明がないと投稿できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
    end

    context '出品できない場合(:category_id)' do
      it 'カテゴリーの情報がないと投稿できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '「」が0の場合は投稿できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
    end

    context '出品できない場合(:status_id)' do
      it '商品の状態についての情報がないと投稿できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it '「status_id」が0の場合は投稿できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
    end

    context '出品できない場合(:which_delivery_fee_id)' do
      it '配送料の負担についての情報がないと投稿できない' do
        @item.which_delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Which delivery fee can't be blank")
      end
      it '「which_delivery_fee_id」が0の場合は投稿できない' do
        @item.which_delivery_fee_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Which delivery fee must be other than 0")
      end
    end

    context '出品できない場合(:prefecture_id)' do
      it '発送元の地域についての情報がないと投稿できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '「prefecture_id」が0の場合は投稿できない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end
    end

    context '出品できない場合(:days_to_delivery_id)' do
      it '発送までの日数についての情報がないと投稿できない' do
        @item.days_to_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to delivery can't be blank")
      end
      it '「days_to_delivery_id」が0の場合は投稿できない' do
        @item.days_to_delivery_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to delivery must be other than 0")
      end
    end

    context '出品できない場合(:price)' do
      it '販売価格についての情報がないと投稿できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格は、¥300より小さい金額の場合は投稿できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it '販売価格は、¥9,999,999より大きい金額の場合は投稿できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it '販売価格は半角数字以外で投稿できない' do
        @item.price = '１１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end 

      it '半角英数混合では投稿できない' do
        @item.price = 'aaaa1111'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end 

      it '半角英語だけでは投稿できない' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end 
    end
  end
end

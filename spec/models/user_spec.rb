require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '登録できる場合' do
      it '全ての情報が正常に入力できている場合は登録できる' do 
        expect(@user).to be_valid
      end
    end
    context '登録できない場合' do
      it 'メールアドレスがないと登録できない' do
        @user.email = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'メールアドレスは＠を含まないと登録できない' do
        @user.password = "sample"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードがないと登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードとパスワード（確認用）が一致しないと登録できない' do
        @user.password_confirmation = "aaaa1111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '「お名前（全角）」がひらがな・カタカナ・漢字以外の場合は登録できない' do
        @user.family_name = "aaaa"
        @user.first_name = "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid", "First name is invalid")
      end
      it '「お名前カナ（全角）」がカタカナ意外の場合は登録できない' do
        @user.family_name_kana = "imei.name.last"
        @user.first_name_kana = "Gimei.name.first"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid", "First name kana is invalid")
      end
    end
  end
end

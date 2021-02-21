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

    context '登録できない場合(:email)' do
      it 'メールアドレスがないと登録できない' do
        @user.email = nil
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
        @user.email = "sample"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
    end

    context '登録できない場合(:password)' do
      it 'パスワードがないと登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードとパスワード（確認用）が一致しないと登録できない' do
        @user.password_confirmation = "aaaa1111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '６文字以上でないと登録できない' do
        @user.password = "aa111"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードが英語のみでは登録できない' do
        @user.password = "aaaaaa"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが数字のみでは登録できない' do
        @user.password = "111111"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが全角では登録できないこと' do
        @user.password = "ａａａａａａ"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    end

    context '登録できない場合(:family_name)' do
      it '「family_name」がないと登録できない' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it '「お名前（全角）」がひらがな・カタカナ・漢字以外の場合は登録できない' do
        @user.family_name = "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
    end

    context '登録できない場合(:first_name)' do
      it '「first_name」がないと登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '「お名前（全角）」がひらがな・カタカナ・漢字以外の場合は登録できない' do
        @user.first_name = "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
    end

    context '登録できない場合(:family_name_kana)' do
      it '「family_name_kan」がないと登録できない' do
        @user.family_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it '「お名前カナ（全角）」がカタカナ意外の場合は登録できない' do
        @user.family_name_kana = "Gimei.name.last"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end
      it '「お名前カナ（全角）」がカタカナ意外の全角文字は登録できない' do
        @user.family_name_kana = "ああああＡＡＡＡ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end
    end

    context '登録できない場合(:first_name_kana)' do
      it '「first_name_kana」がないと登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '「お名前カナ（全角）」がカタカナ意外の場合は登録できない' do
        @user.first_name_kana = "Gimei.name.first"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it '「お名前カナ（全角）」がカタカナ意外の全角文字は登録できない' do
        @user.family_name_kana = "ああああＡＡＡＡ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end
    end

    context '登録できない場合(:birthday)' do
      it '「birthday」がないと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

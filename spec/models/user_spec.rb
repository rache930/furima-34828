require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザー登録できるとき' do
      it 'すべての情報があれば登録できること' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上なら登録できること' do
        @user.password = 'test12'
        @user.password_confirmation = 'test12'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録できないとき' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空だと登録出来ないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは@を含む必要がること' do
        @user.email = 'test.example'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは5文字以下であれば登録できないこと' do
        @user.password = 'test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは英語のみでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters.')
      end
      it 'パスワードは数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters.')
      end
      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password = 'test1234'
        @user.password_confirmation = 'text1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ユーザー本名は、名字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名は、名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名（名字）はが全角日本語でないと保存できないこと' do
        @user.last_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名（名前）は全角日本語でないと保存できないこと' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名のフリガナ（名字）は、必須であること' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank")
      end
      it 'ユーザー本名のフリガナ（名前）は、必須であること' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end
      it 'ユーザー本名のフリガナ（名字）は、全角カタカナでの入力が必須であること' do
        @user.last_name_reading = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名のフリガナ（名前）は、全角カタカナでの入力が必須であること' do
        @user.first_name_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名のフリガナ（名字）は、半角文字だと登録できないこと' do
        @user.last_name_reading = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名のフリガナ（名前）は、半角文字だと登録できないこと' do
        @user.first_name_reading = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
      end
      it '生年月日が必須であること' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end

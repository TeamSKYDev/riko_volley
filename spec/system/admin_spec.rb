require 'rails_helper'

describe '管理者画面のテスト' do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, is_admin: true) }
  before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user2.email
  	fill_in 'user[password]', with: user2.password
  	click_button 'ログイン'
    click_link '管理者'
  end

  context '表示のテスト' do
    it 'ユーザー一覧が表示されているか'do
      expect(page).to have_content user.email
      expect(page).to have_content user2.email
    end
    it 'emailフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'passwordフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it '登録ボタンが表示される' do
      expect(page).to have_button '新規登録'
    end
  end

  context 'ユーザー登録のテスト', js: true do
    it '登録が成功する' do
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      click_button '新規登録'
      expect(page).to have_content '登録完了'
			expect(current_path).to eq '/users'
    end
    it '登録に失敗する', js: true do
      click_button '新規登録'
      expect(page).to have_content '入力に誤り'
			expect(current_path).to eq '/users'
    end
  end

  context '管理者権限のテスト' do
    before do
      sleep 6
      click_link 'ログアウト'
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    it '管理者以外のユーザが遷移できない' do
      visit users_path
      expect(current_path).to eq('/posts')
    end
  end
end
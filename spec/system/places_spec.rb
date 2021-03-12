require 'rails_helper'

describe '場所設定のテスト' do
  let(:user) { create(:user) }
  before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
    click_link '場所'
  end

  it '登録に成功する', js: true do
    fill_in 'place[name]', with: Faker::Lorem.characters(number:5)
    click_button '登録'
    expect(page).to have_content '保存'
  end

  it '登録に失敗する' do
    click_button '登録'
    expect(page).to have_content 'エラー'
  end
end
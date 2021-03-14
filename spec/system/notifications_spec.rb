require 'rails_helper'

describe 'リマインダ設定のテスト' do
  let(:user) { create(:user) }
  let!(:notification) { create(:notification) }
  before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
    click_link 'リマインダ'
  end

  it '更新に成功する', js: true do
    click_button '保存'
    expect(page).to have_content '保存'
  end
  it '更新に失敗する', js: true do
    fill_in 'notification[days_before]', with: ""
    click_button '保存'
    expect(page).to have_content 'エラー'
  end

end
require 'rails_helper'

describe 'ログインしていないときのテスト' do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  before do
    visit posts_path
  end
  context '表示の確認' do
    it 'タブメニューが表示されない' do
      expect(page).to have_no_selector('#admin_menu')
    end
    it '編集画面に遷移できない' do
      visit edit_post_path(post)
      expect(current_path).to eq(posts_path)
    end
    it '管理者画面に遷移できない' do
      visit users_path
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
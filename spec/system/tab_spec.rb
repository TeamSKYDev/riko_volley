require 'rails_helper'

describe 'タブメニューのテスト' do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }
	let!(:exercise) { create(:exercise, post_id: post.id)}
  let!(:place) { create(:place) }
  let!(:notification) { create(:notification) }
  before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
  end

  context 'タブメニューの表示の確認' do
    it '投稿と表示される' do
      expect(page).to have_link '投稿'
    end
    it '場所設定と表示される' do
      expect(page).to have_link '場所設定'
    end
    it 'リマインダと表示される' do
      expect(page).to have_link 'リマインダ'
    end
    it 'アカウントと表示される' do
      expect(page).to have_link 'アカウント'
    end
  end

  context '投稿タブの確認' do
    before do
      click_link '投稿'
    end
    it 'titleフォームが表示される' do
      expect(page).to have_field 'post[title]'
    end
    it 'bodyフォームが表示される' do
      expect(page).to have_field 'post[body]'
    end
    it '投稿ボタンが表示される' do
      expect(page).to have_button '投稿'
    end
  end

  context '場所設定タブの確認' do
    before do
      click_link '場所'
    end
    it '削除リンクが正しく表示される' do
      expect(page).to have_link '削除', href: place_path(place)
    end
    it 'nameフォームが表示される' do
      expect(page).to have_field 'place[name]'
    end
    it '登録ボタンが表示される' do
      expect(page).to have_button '登録'
    end
  end

  context 'リマインダタブの確認' do
    before do
      click_link 'リマインダ'
    end
    it 'status変更ラジオボタンが正しく表示される' do
      expect(page).to have_checked_field 'notification[status]'
      expect(page).to have_unchecked_field 'notification[status]'
    end
    it 'days_beforeフォームが表示される' do
      expect(page).to have_field 'notification[days_before]'
    end
    it '保存ボタンが表示される' do
      expect(page).to have_button '保存'
    end
  end

  context 'アカウントタブの確認' do
    before do
      click_link 'アカウント'
    end
    it '編集ボタンが正しく表示される' do
      expect(page).to have_link '編集'
    end
  end
end


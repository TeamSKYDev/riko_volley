require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit posts_path
    end
    context 'ヘッダーの表示を確認' do
      subject { page }

      it 'ブランドが表示される' do
        brand_link = find_all('a')[0].native.inner_text
        expect(brand_link).to match('りこばれ掲示板')
      end
      it 'ログインリンクが表示される' do
        login_link = find_all('a')[1].native.inner_text
        expect(login_link).to match('ログイン')
      end
    end
    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it '一覧画面に遷移する' do
        brand_link = find_all('a')[0].native.inner_text
        brand_link = brand_link.delete(' ')
        brand_link.gsub!(/\n/, '')
        click_link brand_link
        is_expected.to eq(posts_path)
      end
      it 'ログイン画面に遷移する' do
        login_link = find_all('a')[1].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq(new_user_session_path)
      end
    end
  end

  describe 'ログインしている場合' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it 'ブランドが表示される' do
        brand_link = find_all('a')[0].native.inner_text
        expect(brand_link).to match('りこばれ掲示板')
      end
      it 'ログアウトリンクが表示される' do
        logout_link = find_all('a')[1].native.inner_text
        expect(logout_link).to match("ログアウト")
      end
    end

    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it '一覧画面に遷移する' do
        brand_link = find_all('a')[0].native.inner_text
        brand_link = brand_link.delete(' ')
        brand_link.gsub!(/\n/, '')
        click_link brand_link
        is_expected.to eq(posts_path)
      end
      it 'ログアウトする', js: true do
        sleep 10
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウト'
      end
    end
  end
  describe 'ログインしている場合(管理者)' do
    let(:user2) { create(:user, is_admin: true) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user2.email
      fill_in 'user[password]', with: user2.password
      click_button 'ログイン'
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it '管理者リンクが表示される' do
        brand_link = find_all('a')[1].native.inner_text
        expect(brand_link).to match('管理者')
      end
    end

    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it '管理者画面に遷移する' do
        admin_link = find_all('a')[1].native.inner_text
        admin_link = admin_link.delete(' ')
        admin_link.gsub!(/\n/, '')
        click_link admin_link
        is_expected.to eq(users_path)
      end
    end
  end
end

require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
	let!(:user2) { create(:user) }
  let!(:post) { create(:post, user: user) }
	let!(:post2) { create(:post, user: user2) }
	let(:exercise) { create(:exercise, post: post) }
	let(:exercise2) { create(:exercise, post: post2)}
  let!(:place) { create(:place) }
  let!(:notification) { create(:notification) }
  before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
  end

	describe '新規投稿のテスト', js: true do
		it '投稿に成功する(練習あり)' do
			click_link '日程の追加'
			fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
			fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
			click_button '投稿'
			expect(page).to have_content '投稿完了'
		end
		it '投稿に成功する(練習なし)' do
			find('.remove_fields').click
			fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
			fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
			click_button '投稿'
			expect(page).to have_content '投稿完了'
		end
		it '投稿に失敗する' do
			click_button '投稿'
			expect(page).to have_content '入力に誤り'
			expect(current_path).to eq('/posts')
		end
	end

	describe '投稿編集のテスト' do
		context '自分の投稿の編集画面へ遷移' do
			it '遷移ができる' do
				visit edit_post_path(post)
				expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
			end
		end
		context '他人の投稿の編集画面への遷移' do
		  it '遷移できない' do
		    visit edit_post_path(post2)
		    expect(current_path).to eq(posts_path)
		  end
		end
		describe '表示の確認' do
			before do
				visit edit_post_path(post)
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

		context 'フォームの確認' do
			it '編集に成功する' do
				visit edit_post_path(post)
				click_button '投稿'
				expect(page).to have_content '編集'
				expect(current_path).to eq '/posts'
			end
			it '編集に失敗する' do
				visit edit_post_path(post)
				fill_in 'post[title]', with: ''
				click_button '投稿'
				expect(page).to have_content '入力に誤り'
				expect(current_path).to eq '/posts/' + post.id.to_s
			end
		end
	end

	describe '一覧画面のテスト' do
  	before do
  		visit posts_path
  	end
  	context '表示の確認' do
  		it '投稿一覧と表示される' do
  			expect(page).to have_content '投稿一覧'
  		end

  		it '自分と他人の投稿のtitleが表示される' do
  			expect(page).to have_content post.title
  			expect(page).to have_content post2.title
  		end
  		it '自分と他人の投稿のbodyが表示される' do
  			expect(page).to have_content post.body
  			expect(page).to have_content post2.body
  		end
  	end
		context '自分の投稿の確認' do
  		it '投稿の編集リンクが表示される' do
  			expect(page).to have_link '編集', href: edit_post_path(post)
  		end
  		it '投稿の削除リンクが表示される' do
  			expect(page).to have_link '削除', href: post_path(post)
  		end
		end
		context '他人の投稿の確認' do
  		it '投稿の編集リンクが表示されない' do
  			expect(page).to have_no_link '編集', href: edit_post_path(post2)
  		end
  		it '投稿の削除リンクが表示されない' do
  			expect(page).to have_no_link '削除', href: post_path(post2)
  		end
		end
	end

end
require 'rails_helper'

RSpec.describe "Postモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user_id: user.id) }

    context "titleカラム" do
      it "空欄でないこと" do
        post.title = ''
        expect(post.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Exerciseモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:exercises).macro).to eq :has_many
      end
    end
  end
end
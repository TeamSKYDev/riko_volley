require 'rails_helper'

RSpec.describe "Placeモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let!(:place) { create(:place) }

    context "nameカラム" do
      it "空欄でないこと" do
        place.name = ''
        expect(place.valid?).to eq false;
      end
    end
  end
end
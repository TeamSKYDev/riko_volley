class PlacesController < ApplicationController

  before_action :check_sign_in,          only: %i[create destory]

  def sort
    # accept the post with all the items to sort.
    params[:place].each_with_index do |id, index|
      Place.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  def create
    place = Place.new(place_params)
    place.position = 0
    if place.save
      flash[:notice] = "保存しました"
    else
      flash[:error] = "エラー"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    place = Place.find(params[:id])
    if place.destroy
      flash[:notice] = "削除しました"
    else
      flash[:error] = "エラー"
    end
    redirect_back(fallback_location: root_path)

  end

  private
  def place_params
    params.require(:place).permit(:name)
  end
end

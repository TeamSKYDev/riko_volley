class PlacesController < ApplicationController
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
    respond_to do |format|
      if place.save
        @places = Place.order(:position)
        @place = Place.new
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    place = Place.find(params[:id])
    respond_to do |format|
      if place.update(place_params)
        @places = Place.order(:position)
        @place = Place.new
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def destroy
    place = Place.find(params[:id])
    respond_to do |format|
      if place.destroy
        @places = Place.order(:position)
        @place = Place.new
        format.html { redirect_to root_path }
        format.js
      end
    end

  end

  private
  def place_params
    params.require(:place).permit(:name)
  end
end

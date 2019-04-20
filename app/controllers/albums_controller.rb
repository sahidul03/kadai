class AlbumsController < ApplicationController
  before_action :check_authentication

  def index
    @albums = current_user.albums.order(created_at: :DESC)
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def album_params
    params.require(:album).permit(:title, :image).merge(:user_id => current_user.id)
  end
end

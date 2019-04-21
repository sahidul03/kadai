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

  def tweet
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI.parse(ENV['TWEET_POST_URL'])
    header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }
    body = {
        text: params['title'],
        url: ENV['DOMAIN_WITH_PORT'] + params['image']
    }
    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json
    # Send the request
    response = http.request(request)

    redirect_to albums_path, notice: 'ツイートを投稿しました'
  end

  private
  def album_params
    params.require(:album).permit(:title, :image).merge(:user_id => current_user.id)
  end
end

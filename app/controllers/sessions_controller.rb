class SessionsController < ApplicationController
  before_action :check_authentication, only: [:callback, :tweeter_auth]

  def new
    redirect_to root_path if current_user
  end

  def create
    flash.now[:alert] = []
    flash.now[:alert] << 'ユーザーIDを入力してください' unless params[:username].present?
    flash.now[:alert] << 'パスワードを入力してください' unless params[:password].present?

    if params[:username].present? && params[:password].present?
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_url, notice: 'ログインしています'
      else
        flash.now[:alert] = ['ユーザーID、もしくはパスワードが正しくありません。']
      end
    end
    render 'new' if flash.now[:alert].any?
  end

  def callback
    content_type = 'application/x-www-form-urlencoded'
    accept = 'application/json;charset=UTF-8'

    response = HTTParty.post(
        ENV['REQUEST_URL_FOR_TOKEN'],
        :headers => {
            'Content-Type'      => content_type,
            'Accept'            => accept
        },
        :body => {
            'code'              => params[:code],
            'redirect_uri'      => ENV['CALLBACK_URL'],
            'client_id'         => ENV['CLIENT_ID'],
            'client_secret'     => ENV['CLIENT_SECRET'],
            'grant_type'        => 'authorization_code'
        }
    )

    session[current_user.id] = response['access_token']
    redirect_to albums_path
  end

  def tweeter_auth
    redirect_to ENV['REDIRECT_URL_FOR_CODE'] + '?client_id=' + ENV['CLIENT_ID'] + '&redirect_uri=' + ENV['CALLBACK_URL'] + '&response_type=code'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'ログアウトしました'
  end

end

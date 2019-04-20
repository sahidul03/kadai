class SessionsController < ApplicationController

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

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'ログアウトしました'
  end

end

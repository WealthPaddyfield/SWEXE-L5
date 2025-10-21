class TopController < ApplicationController
  def main
    render "login_form"
  end
  
def login
  user = User.find_by(uid: params[:uid], pass: params[:pass])
  if user
    session[:login_uid] = user.uid
    redirect_to tweets_path
  else
    flash[:alert] = "ログインに失敗しました"
    render :main
  end
end

  def logout
    session.delete(:login_uid)
    redirect_to tweets_path
  end
end
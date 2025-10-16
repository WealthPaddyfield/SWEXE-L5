class TopController < ApplicationController
  def main
    render "login_form"
  end
  
  def login
    if User.find_by(uid: params[:uid]) and User.find_by(pass: params[:pass])
      session[:login_uid] = params[:uid]
      redirect_to tweets_path
    end
  end
  
  def logout
    session.delete(:login_uid)
    redirect_to tweets_path
  end
end
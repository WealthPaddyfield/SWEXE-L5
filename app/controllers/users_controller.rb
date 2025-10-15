class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new 
  end
  
  def create
    User.create(ui: params[:user][:uid],
    pass: params[:user][:pass])
    redirect_to root_path
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to user_path
  end
end

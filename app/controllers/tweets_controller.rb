class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new 
  end
  
  def create
    Tweet.create(message: params[:tweet][:message],user_id: 1)
    redirect_to tweets_path
  end
  
  def destroy
    Tweet.find(params[:id]).destroy
    redirect_to tweets_path
  end
  def like(user)
    likes.create(user_id: user.id)
  end
  
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def liked?(user) #いいね済みか調べる(true / false)
    like_users.include?(user)
  end
end
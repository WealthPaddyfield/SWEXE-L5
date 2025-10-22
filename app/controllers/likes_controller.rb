class LikesController < ApplicationController
    def create
        tweet = Tweet.find(params[:tweet_id])
        #user = User.find_by(uid: session[:login_uid])
        unless tweet.liked?(current_user)
            tweet.like(current_user)
        end
        redirect_to root_path
    end
    def destroy
        tweet = Tweet.find(params[:id])
        #user = User.find_by(uid: session[:login_uid])
        if tweet.liked?(current_user)
            tweet.unlike(current_user)
        end
        redirect_to root_path
    end
end

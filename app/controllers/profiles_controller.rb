class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    return redirect_to profile_path if current_user.profile
    @profile = current_user.build_profile
  end

  def create
    return redirect_to profile_path if current_user.profile

    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to root_path
  end

  private

  def set_profile
    @profile = current_user.profile
    return if @profile
    redirect_to new_profile_path
  end

  def profile_params
    params.require(:profile).permit(:display_name, :bio)
  end
end

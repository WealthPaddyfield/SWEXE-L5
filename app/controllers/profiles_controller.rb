class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
    return redirect_to new_profile_path unless @profile
  end

  def new
    return redirect_to profile_path if current_user&.profile
    @profile = current_user&.build_profile || Profile.new
  end

  def create
    # current_user が無ければ戻す（require_login があるはずですが念のため）
    return redirect_to root_path unless current_user

    # 既に profile があれば作らない
    return redirect_to profile_path if current_user.profile

    @profile = current_user.build_profile(profile_params_safe)
    if @profile.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    return redirect_to new_profile_path unless @profile
  end

  def update
    return redirect_to new_profile_path unless @profile

    if @profile.update(profile_params_safe)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    return redirect_to root_path unless @profile
    @profile.destroy
    redirect_to root_path
  end

  private

  def set_profile
    @profile = current_user&.profile
  end

  # profile パラメータが無ければ空ハッシュを返す安全版
  def profile_params_safe
    params.fetch(:profile, {}).permit(:display_name, :bio)
  end
end

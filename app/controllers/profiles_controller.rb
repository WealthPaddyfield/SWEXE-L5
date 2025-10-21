class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
    # current_user のプロフィールを表示
  end

  def new
    if current_user.profile
      redirect_to profile_path, notice: "既にプロフィールが作成されています。"
      return
    end
    @profile = current_user.build_profile
  end

  def create
    if current_user.profile
      redirect_to profile_path, alert: "プロフィールは既に存在します。"
      return
    end

    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path, notice: "プロフィールを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "プロフィールを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    redirect_to root_path, notice: "プロフィールを削除しました。"
  end

  private

  def set_profile
    @profile = current_user.profile
    unless @profile
      redirect_to new_profile_path, alert: "プロフィールが見つかりません。新規作成してください。"
    end
  end

  def profile_params
    params.require(:profile).permit(:display_name, :bio, :avatar_url, :website)
  end
end

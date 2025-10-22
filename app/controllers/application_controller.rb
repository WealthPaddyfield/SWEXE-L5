# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Only allow modern browsers ... (既存記述を残す)
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  private

=begin
  def current_user
    return @current_user if defined?(@current_user)
    if session[:login_uid].present?
      @current_user = User.find_by(uid: session[:login_uid])
    else
      @current_user = nil
    end
  end
=end

  def current_user
    if session[:login_uid]
      User.find_by(uid: session[:login_uid])
    end
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to top_main_path, alert: "ログインしてください。"
    end
  end
end

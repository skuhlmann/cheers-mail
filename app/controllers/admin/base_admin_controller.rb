class Admin::BaseAdminController < ActionController::Base
  before_action :require_admin
  protect_from_forgery with: :exception
  helper_method :current_user
  layout "application"

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, notice: "Unauthorized"
    end
  end

  def index
    @users = User.all
  end
end

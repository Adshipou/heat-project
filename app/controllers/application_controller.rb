class ApplicationController < ActionController::Base
  before_action :demo_auth
  helper_method :admin_user?, :super_admin_user?, :admin_view_mode?, :member_view_mode?

  private

  def demo_auth
    session[:authenticated] = true if current_user.present?
  end

  def admin_user?
    current_user.present? && current_user.admin?
  end

  def super_admin_user?
    current_user.present? && current_user.super_admin?
  end

  def admin_view_mode?
    admin_user? && session[:view_mode] != "member"
  end

  def member_view_mode?
    !admin_view_mode?
  end

  def require_admin!
    return if admin_view_mode?

    redirect_to root_path, alert: "Admins only."
  end

  def require_admin_account!
    return if admin_user?

    redirect_to root_path, alert: "Admins only."
  end
end

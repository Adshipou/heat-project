class ViewModesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin_account!

  def update
    mode = params[:mode].to_s
    if %w[admin member].include?(mode)
      session[:view_mode] = mode
      redirect_back fallback_location: root_path, notice: "Switched to #{mode} view."
    else
      redirect_back fallback_location: root_path, alert: "Invalid view mode."
    end
  end
end

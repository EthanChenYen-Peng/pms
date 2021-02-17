class Admin::ApplicationController < ApplicationController
  before_action :require_admin

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = t('unauthorized_access')
      redirect_to root_path
    end
  end
end

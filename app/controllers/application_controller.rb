class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'pms', password: 'pms-password' if Rails.env.production?

  around_action :switch_locale

  # Allow these methods to be avaliable in views.
  helper_method :current_user, :login?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login?
    current_user ? true : false
  end

  def require_user
    unless login?
      flash[:alert] = t('require_login')
      redirect_to login_path
    end
  end

  def require_the_same_user
    if current_user != @project.user
      flash[:alert] = t('project.access.unauthorized')
      redirect_to projects_path
    end
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end

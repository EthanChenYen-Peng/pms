class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'pms', password: 'pms-password' if Rails.env.production?

  # Allow these methods to be avaliable in views.
  helper_method :current_user, :login?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login?
    current_user ? true : false
  end

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end

class PagesController < ApplicationController
  def home
    redirect_to user_projects_path(current_user) if login?
  end
end

class PagesController < ApplicationController
  def home
    redirect_to projects_path if login?
  end
end


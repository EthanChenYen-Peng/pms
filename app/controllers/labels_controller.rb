class LabelsController < ApplicationController
  before_action :require_user

  def destroy
    @project = Project.friendly.find(params[:project_id])

    if current_user != @project.user
      flash[:alert] = t('project.access.unauthorized')
      redirect_to projects_path
    end

    @label = Label.find(params[:id])
    @project.labels.destroy(@label)
    head :ok
  end
end

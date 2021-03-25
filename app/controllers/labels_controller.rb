class LabelsController < ApplicationController
  before_action :require_user

  def destroy
    @project = Project.friendly.find(params[:project_id])

    respond_to do |format|
      if current_user != @project.user
        format.html do
          flash[:alert] = t('project.access.unauthorized')
          redirect_to projects_path
        end
        format.json do
          render json: t('project.access.unauthorized'),
                 status: :unauthorized
        end
      else
        @label = Label.find(params[:id])
        @project.labels.destroy(@label)
        format.html do
          head :ok
        end
        format.json do
          render json: { label_str: @project.label_str },
                 status: :ok
        end
      end
    end
  end
end

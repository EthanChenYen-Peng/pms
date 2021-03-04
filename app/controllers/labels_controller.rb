class LabelsController < ApplicationController
  def remove
    @project = Project.find(params[:project_id])
    @label = Label.find(params[:id])

    @project.labels.destroy(@label)
    head :ok
  end
end

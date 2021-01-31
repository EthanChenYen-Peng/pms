class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = 'Project has been created.'
      redirect_to project_path(@project)
    else
      flash[:alert] = 'Project has not been created.'
      render :new
    end
  end

  def show; end

  def edit
  end

  def update

    if @project.update(project_params)
      flash[:notice] = 'Project has been updated.'
      redirect_to project_path(@project)
    else
      flash[:alert] = 'Project has not been updated.'
      render :edit
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :content)
  end
end

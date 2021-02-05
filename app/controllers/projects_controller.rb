require 'pry'
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    if params[:sort_by] == 'due_date'
      @projects = Project.order(due_date: :asc)
    else
      @projects = Project.order(created_at: :desc)
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = t('project.create.success')
      redirect_to project_path(@project)
    else
      flash[:alert] = t('project.create.failure')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = t('project.update.success')
      redirect_to project_path(@project)
    else
      flash[:alert] = t('project.update.failure')
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = t('project.delete.success')
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :content, :due_date)
  end
end

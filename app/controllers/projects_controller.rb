require 'pry'
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  ORDER_DIRECTIONS = ['desc', 'asc']
  FILEDS_TO_SORT_BY = ['created_at', 'due_date']

  def index
    @projects = Project.order(project_sort_by_params)
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

  def project_sort_by_params
    order_direction = ORDER_DIRECTIONS.include?(params[:order_direction]) ? params[:order_direction] : 'desc'
    sort_by = FILEDS_TO_SORT_BY.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'

    @selected_order_direction = t(order_direction.to_sym)
    @selected_sort_by = t(sort_by.to_sym)
    Hash[sort_by, order_direction]
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :content, :due_date)
  end
end

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :require_user
  before_action :require_the_same_user, only: %i[edit update destroy]

  ORDER_DIRECTIONS = ['desc', 'asc']
  FILEDS_TO_SORT_BY = ['created_at', 'due_date', 'priority']
  PROJECT_STATUS = ['todo', 'doing', 'done' ]

  def index
    set_project_query_params
    if @selected_status == 'all'
      @projects = Project.all
    else
      @projects = Project.where(status: @selected_status)
    end
    @projects = @projects.title_contains(@search_terms).order(project_sort_by_params).page(params[:page])
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)

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

  def set_project_query_params
    @selected_order_direction = ORDER_DIRECTIONS.include?(params[:order_direction]) ? params[:order_direction] : 'desc'
    @selected_sort_by = FILEDS_TO_SORT_BY.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
    @selected_status = PROJECT_STATUS.include?(params[:status]) ? params[:status] : 'all'
    @search_terms = params[:search] || ''
  end
 
  # TODO: Command an query in a function. Might not be a good idea.
  def project_sort_by_params
    Hash[@selected_sort_by, @selected_order_direction]
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :content, :due_date)
  end

  def require_the_same_user
    if current_user != @project.user
      flash[:alert] = t('project.access.unauthorized')
      redirect_to projects_path
    end
  end
end

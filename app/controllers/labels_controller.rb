class LabelsController < ApplicationController
  before_action :set_label, only: %i[show edit destroy update]
  before_action :require_user
  before_action :require_the_same_user, only: [:edit, :update, :destroy]

  def index
    @labels = current_user.labels.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.new(label_params)

    if @label.save
      flash[:notice] = t('label.create.success')
      redirect_to labels_path
    else
      flash.now[:alert] = t('label.create.failure')
      render :new
    end
  end

  def edit; end

  def update
    if @label.update(label_params)
      flash[:notice] = t('label.update.success')
      redirect_to labels_path
    else
      flash.now[:alert] = t('label.update.failure')
      render :edit
    end
  end

  def destroy
    @label.destroy
    flash[:notice] = t('label.delete.success')
    redirect_to labels_path
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end

  def require_the_same_user
    if current_user != @label.user
      flash[:alert] = t('label.access.unauthorized')
      redirect_to labels_path
    end
  end
end

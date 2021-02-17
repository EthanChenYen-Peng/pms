class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @users = User.page(params[:page])
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = t('user.update.success')
      redirect_to admin_user_path(@user)
    else
      flash.now[:alert] = t('user.update.failure')
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t('user.create.success')
      redirect_to admin_users_path
    else
      flash.now[:alert] = t('user.create.failure')
      render :new
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t('user.delete.success')
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

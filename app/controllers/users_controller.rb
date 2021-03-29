class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :require_user, except: %i[new create]
  before_action :require_the_same_user, expect: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t('user.create.success')
      redirect_to root_path
    else
      flash.now[:alert] = t('user.create.failure')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = t('user.update.success')
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def require_the_same_user
    if @user != current_user
      flash[:alert] = t('unauthorized_access')
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end
end

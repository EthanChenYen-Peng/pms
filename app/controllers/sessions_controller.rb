class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = t('session.create.success')
      redirect_to root_path
    else
      flash.now[:alert] = t('session.create.failure')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('session.delete.success')
    redirect_to root_path
  end
end

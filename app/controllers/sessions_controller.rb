class SessionsController < ApplicationController
  def new
    @user = User.new
    render 'login'
  end

  def create
    user = User.find_by email: params[:email]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_back '/' # redirect back, use root as a default fallback
    else
      flash_msg 'upps.. something went wrong', 'error'
      @error = true
      render 'sessions/login'
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end

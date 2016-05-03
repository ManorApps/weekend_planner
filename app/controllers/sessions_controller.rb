class SessionsController < ApplicationController
  def dashboard
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    else
      redirect_to root_path, alert: "Login failed: invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have succesfully logged out"
  end
end

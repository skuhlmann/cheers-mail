class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_index_path
    else
      flash[:errors] = "INVALID CREDENTIALS"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end

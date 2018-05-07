class SessionsController < ApplicationController
  def new
    # @session = Session.new()
    render :new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by(email: email)
    authenticated_user = authenticate(user, password)
    if authenticated_user
      sign_in(authenticated_user)
      redirect_to new_secret_path
    else
      redirect_to new_session_path
    end
  end
end

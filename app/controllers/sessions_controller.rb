class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: user_params[:email])
    password = user_params[:password]
    authenticated_user = authenticate(user, password)

    if authenticated_user
      sign_in(authenticated_user)
      redirect_to new_secret_path
    else
      redirect_to new_session_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

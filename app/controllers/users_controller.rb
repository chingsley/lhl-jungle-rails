class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    pp user
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      puts user.errors.full_messages
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :picture)
  end

end
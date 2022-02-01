class SessionsController < ApplicationController
  def new
  end

  def create
    email = session_params[:email]
    password = session_params[:password]
    if user = User.authenticate_with_credentials(email, password)
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def create__depricated
    user = User.find_by_email(session_params[:email])

    # If the user exists AND the password entered is correct.
    if user && user.authenticate(session_params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end


  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

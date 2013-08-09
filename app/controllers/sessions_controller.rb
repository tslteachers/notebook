class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by :name => params["name"]
    if user && user.authenticate(params["password"])
        session[:login_id] = user.id
        redirect_to root_url
    else
      redirect_to sign_in_url, notice: "Bad username or password"
    end

  end

  def destroy
    reset_session
    redirect_to notes_url
  end






end

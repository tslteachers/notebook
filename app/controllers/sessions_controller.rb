class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by :name => params["name"]
    if user
      if user.authenticate(params["password"])
        redirect_to root_url
      else
        redirect_to sign_in_url, notice: "Bad username or password"
      end
    else
        redirect_to sign_in_url, notice: "Bad username or password"
    end

  end

  def destroy
    reset_session
    redirect_to notes_url
  end






end

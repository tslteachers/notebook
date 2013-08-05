class SessionsController < ApplicationController

  def new

  end

  def create
    # Parameters: {"utf8"=>"✓", "authenticity_token"=>"p8tdwgPIDQH0x4iQUmyO5fee6NTD1v3e0IyW2/UW8xE=", "name"=>"Jeff", "password"=>"[FILTERED]", "commit"=>"Let Me In"}

    # user = User.find_by_name(params["name"])
    user = User.find_by :name => params["name"]
    if user
      if user.authenticate(params["password"])
        # We're signed in!
        session[:login_id] = user.id
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

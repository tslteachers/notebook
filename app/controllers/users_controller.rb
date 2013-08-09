class UsersController < ApplicationController

  before_action :authorize_user, only: [:edit, :update, :destroy]

  def authorize_user
    @user = User.find_by_id(params[:id])
    @current_user = User.find_by_id(session[:login_id])

    if @user != @current_user
      redirect_to root_url, notice: "Nice try!"
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @current_user = User.find_by_id(session[:login_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:name]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      session[:login_id] = @user.id
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
      redirect_to root_url, notice: "Nice try!"
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.name = params[:name]
    @user.password_digest = params[:password_digest]

    if @user.save
      redirect_to users_url
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end
end

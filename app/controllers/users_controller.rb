class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new
    end
  end

  def import
    if params[:file].present?
      User.import(params[:file])
      redirect_to users_path, notice: "Users imported successfully."
    else
      redirect_to users_path, alert: "Please upload a CSV file."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end

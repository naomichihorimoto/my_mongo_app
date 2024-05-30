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
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def import
    if params[:file].present?
      result = User.import(params[:file])
      if result[:errors].any?
        flash[:alert] = "There were errors with the following rows: #{result[:errors].join(", ")}"
      else
        flash[:notice] = "Users imported successfully."
      end
    else
      flash[:alert] = "Please upload a CSV file."
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end

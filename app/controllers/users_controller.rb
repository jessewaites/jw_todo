# app/controllers/users_controller.rb
class UsersController < ApplicationController
  # before_action :authenticate_user! # Ensure user is signed in

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = "You are not authorized to edit this user."
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "User updated successfully."
        redirect_to @user
      else
        render "edit", status: :unprocessable_entity
      end
    else
      flash[:alert] = "You are not authorized to update this user."
      redirect_to users_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user || current_user&.admin? # Add admin check if needed
      @user.destroy
      flash[:notice] = "User deleted successfully."
      redirect_to users_path
    else
      flash[:alert] = "You are not authorized to delete this user."
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :other_attribute) # Add permitted attributes
  end
end

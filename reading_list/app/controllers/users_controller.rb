class UsersController < ApplicationController
  before_action :current_user, only: [:show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to links_path(user_id: @user.id)
    else
      flash.now[:errors] = @user.errors.full_messages.join(", ")
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

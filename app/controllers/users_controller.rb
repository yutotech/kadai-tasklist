class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end

class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :admin_user_current

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーを作成しました'
    else
      render :new
   end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to admin_users_path, notice: 'ユーザー編集しました'
    else
        render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
    redirect_to admin_users_path , notice: 'ユーザー削除できませんでした'
    end  
  end

  private
  
  def admin_user_current
    redirect_to tasks_path, notice: '管理者以外はアクセスできません'  unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end

class AdminController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :reset]
  before_action :authenticate_user!
  before_action :authorize_admin!
  
  def index
    @users = User.all.order(:created_at)
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Random.rand(100000..999999)
    
    if @user.save
      redirect_to admin_index_path, flash: {
        notice: 'User created', 
        password: "
        Please let the user have 
        the password below to login and 
        set a new password
        
        password : #{@user.password}
        "
      }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_index_path, notice: "User updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_index_path, notice: "User deleted"
    else
      redirect_to admin_index_path, status: :unprocessable_entity, notice: "Error deleting"
    end
  end

  # resets a given user's password by generating a new 6 digit password
  def reset
    @user.password = Random.rand(100000..999999)
    @user.sign_in_count = 0
    if @user.save
      redirect_to admin_index_path, flash: {
        notice: "Password reset successful",
        password: "
        Please let the user have 
        the password below to login and 
        set a new password
        
        password : #{@user.password}
        "
      }
    else
      redirect_to admin_index_path, status: :unprocessable_entity, notice: "Error reseting"
    end
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Access Denied" unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:first_name, :father_name, :last_name, :email, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

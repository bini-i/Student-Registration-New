class AdminController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :authenticate_user!
  before_action :authorize_admin!
  
  def index
    @users = User.all
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Random.rand(1000..9999)
    puts @user
    if @user.save
      puts "proceed creating a user"
      puts "passworrd:- #{@user.password}"
      redirect_to admin_index_path, notice: 'User created'
    else
      puts "abort creating a user"
      redirect_to admin_index_path, alert: "Unable to create user"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_index_path, notice: "User updated"
    else
      redirect_to admin_index_path, alert: "Unable to update user"
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

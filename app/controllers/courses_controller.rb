class CoursesController < ApplicationController
  before_action :get_department
  before_action :set_course, only: %i[ show edit update destroy_form destroy ]

  # GET /courses or /courses.json
  def index
    session[:step] = session[:course_params] = nil
    @courses = @department.courses
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    session[:course_params] ||= {}
    @course = @department.courses.build
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    session[:course_params].deep_merge!(course_params) if params[:course]
    @course = @department.courses.build(session[:course_params])
    @course_list = Course.pluck(:course_name)

    @course.current_step = session[:step]

    if @course.valid?
      if params[:back_button]
        @course.previous_step
      elsif @course.last_step?
        @course.save
      else 
        @course.next_step
      end
      
      session[:step] = @course.current_step
    end

    if @course.new_record?
      render "new"
    else
      session[:step] = session[:course_params] = nil
      redirect_to department_courses_path(@department), notice: "Course was successfully created."
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to department_course_path(@department), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_form
    @user = User.new
  end
  
  # DELETE /courses/1 or /courses/1.json
  def destroy
    # find the user from db, if not found(email is wrong) set it to new user object 
    @user = User.find_for_authentication(email: params[:user][:email])
    if @user && @user.valid_password?(params[:user][:password])
      # auth succesful and course destroyed
      @course.destroy
      redirect_to department_courses_path(@department), notice: "Course was successfully destroyed."
    else
      # auth NOT successful and destroy form rendered
      @user = @user || User.new
      @user.errors.add(:base, "email or password wrong, try again!")
      render :destroy_form, status: :unprocessable_entity
    end
  end

  private
    def get_department
      @department = Department.find(params[:department_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = @department.courses.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:course_name, :credit_hour, :ects, :course_id, :department_id)
    end
end

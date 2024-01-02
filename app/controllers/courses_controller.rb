class CoursesController < ApplicationController
  before_action :get_department
  before_action :set_course, only: %i[ show edit update destroy_form destroy ]

  # GET /department/1/courses or /department/1/courses.json
  def index
    session[:step] = session[:course_params] = session[:prerequisite] = nil
    @courses = @department.courses
  end

  # GET /department/1/courses/1 or /department/1/courses/1.json
  def show
    redirect_to department_courses_path(@department)
  end

  # GET /department/1/courses/new
  def new
    session[:course_params] ||= {}
    session[:prerequisite] ||= []
    @course = @department.courses.build
  end

  # GET /department/1/courses/1/edit
  def edit
    session[:course_params] ||= {}
    session[:prerequisite] ||= @course.prerequisite_courses.pluck(:course_name)
  end

  # POST /department/1/courses or /department/1/courses.json
  def create
    session[:course_params].deep_merge!(course_params) if params[:course]
    @course = @department.courses.build(session[:course_params])

    @course_list = Course.pluck(:course_name)

    @course.current_step = session[:step]

    if @course.valid?
      if params[:back_button]
        @course.previous_step
      elsif params[:add_prerequisite]
        if Course.where(course_name: params[:course][:prerequisite_course_name]).empty?
          @course.errors.add(:base, "Course '#{params[:course][:prerequisite_course_name]}' does NOT exist")
        elsif session[:prerequisite].include? params[:course][:prerequisite_course_name]
          @course.errors.add(:base, "Course already added")
        else
          session[:prerequisite] << params[:course][:prerequisite_course_name]
        end
      elsif params[:remove_prerequisite]
        session[:prerequisite].delete(params[:remove_prerequisite])
      elsif @course.last_step?
        if @course.save
          session[:prerequisite].each do |prerequisite_course|
            Prerequisite.create(course_id: @course.id, prerequisite_course_id: Course.find_by(course_name: prerequisite_course).id)
          end
        end
      else 
        @course.next_step
      end
      
      session[:step] = @course.current_step
    end

    if @course.new_record?
      render "new"
    else
      session[:step] = session[:course_params] = session[:prerequisite] = nil
      redirect_to department_courses_path(@department), notice: "Course was successfully created."
    end
  end

  # PATCH/PUT /department/1/courses/1 or /department/1/courses/1.json
  def update
    session[:course_params].deep_merge!(course_params) if params[:course]
    @course.assign_attributes(session[:course_params])

    @course_list = Course.pluck(:course_name)

    @course.current_step = session[:step]

    if @course.valid?
      if params[:back_button]
        @course.previous_step
      elsif params[:add_prerequisite]
        if Course.where(course_name: params[:course][:prerequisite_course_name]).empty?
          @course.errors.add(:base, "Course '#{params[:course][:prerequisite_course_name]}' does NOT exist")
        elsif session[:prerequisite].include? params[:course][:prerequisite_course_name]
          @course.errors.add(:base, "Prerequisite course already added")
        else
          Prerequisite.create(course_id: @course.id, prerequisite_course_id: Course.find_by(course_name: params[:course][:prerequisite_course_name]).id)
          session[:prerequisite] << params[:course][:prerequisite_course_name]
          @course.errors.add(:base, "Prerequisite course added")
        end
      elsif params[:remove_prerequisite]
        @course.prerequisite_courses.delete(Course.find_by(course_name: params[:remove_prerequisite]))
        session[:prerequisite].delete(params[:remove_prerequisite])
        @course.errors.add(:base, "Prerequisite course removed")
      elsif @course.last_step?
        if @course.update(session[:course_params])
          session[:step] = session[:course_params] = session[:prerequisite] = nil
          redirect_to department_courses_path(@department), notice: "Course was successfully updated."
          return
        end
      else 
        @course.next_step
      end
      
      session[:step] = @course.current_step

      render "edit"
    end
  end

  def destroy_form
    @user = User.new
  end
  
  # DELETE /department/1/courses/1 or /department/1/courses/1.json
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
      params.require(:course).permit(:course_name, :credit_hour, :ects, :department_id)
    end
end

class CoursesController < ApplicationController
  before_action :get_department
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = @department.courses
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = @department.courses.build
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = @department.courses.build(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to department_courses_path(@department), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
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

  # DELETE /courses/1 or /courses/1.json
  def destroy
    puts "got here"
    # @course.destroy

    respond_to do |format|
      format.html { redirect_to department_courses_path(@department), notice: "Course was successfully destroyed." }
      format.json { head :no_content }
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

class StudentsController < ApplicationController
  before_action :get_department
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /department/1/students or /department/1/students.json
  def index
    @students = @department.students
  end

  # GET /department/1/students/1 or /department/1/students/1.json
  def show
    
  end

  # GET /department/1/students/new
  def new
    @student = @department.students.build
    unless current_user.registrar_desk?
      redirect_to root_path, notice: "Access denied"
    end
  end

  # GET /department/1/students/1/edit
  def edit
  end

  # POST /department/1/students or /department/1/students.json
  def create
    @student = @department.students.build(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to department_students_path(@department), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /department/1/students/1 or /department/1/students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to department_students_path(@department), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /department/1/students/1 or /department/1/students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_department
      @department = Department.find(params[:department_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :father_name, :last_name, :gender, :phone, :nationality, :dob, :martial_status, :admission_type, address: [:woreda, :city, :region])
    end
end

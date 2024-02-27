class RegistrationsController < ApplicationController
  before_action :get_department
  before_action :set_registration, only: %i[ show edit update destroy ]

  before_action :get_academic_years

  # GET /registrations or /registrations.json
  def index
    session[:step] = session[:registration_params] = session[:course_id] = session[:student_id_params] = nil
    @registrations = @department.registrations
  end

  def academic_year_registrations
    @first_class_year = @department.registrations.where(academic_year: params[:academic_year]).pluck(:class_year).uniq.sort.first

    redirect_to class_year_registrations_path(@department, params[:academic_year], @first_class_year)
  end

  def class_year_registrations
    @class_years = @department.registrations.where(academic_year: params[:academic_year]).pluck(:class_year).uniq.sort

    @semester_registrations = @department.registrations.where(academic_year: params[:academic_year], class_year: params[:class_year]).includes(:teaching).group_by(&:semester)
   
    render :index
  end

  def registered_students
    @registrations = @department.registrations.where(academic_year: params[:academic_year], class_year: params[:class_year], semester: params[:semester])
    
    @registered_students = @registrations.map { |reg| reg.student }.sort_by(&:section)
  end

  # GET /registrations/1 or /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    session[:registration_params] ||= {}
    session[:course_id_params] ||= {}

    @registration = @department.registrations.build
  end

  # GET /registrations/1/edit
  def edit
    session[:registration_params] ||= {}
    session[:course_id_params] ||= {}
  end

  # POST /registrations or /registrations.json
  def create
    console
    session[:registration_params].deep_merge!(registration_params) if params[:registration]
    @registration = @department.registrations.build(session[:registration_params])

    if session[:registration_params]["class_year"] && session[:registration_params]["semester"]
      @active_students = @department.students.where(class_year: session[:registration_params]["class_year"], semester: session[:registration_params]["semester"]).active
      
      @semester_courses = @department.courses.where(class_year: session[:registration_params]["class_year"], semester: session[:registration_params]["semester"])

      @sections = @active_students.pluck(:section).uniq.sort
    end

    @registration.current_step = session[:step]

    if @registration.valid?
      if params[:back_button]
        @registration.previous_step
      elsif @registration.current_step == "courses"
        if params[:course_id]
          session[:course_id_params] = params[:course_id]
          @registration.next_step
        else
          @registration.errors.add(:base, "Select atleast one course from the list below")
        end
      elsif @registration.current_step == "students"
        if params[:student_id]
          session[:student_id_params] = params[:student_id]
          @registration.next_step
        else
          @registration.errors.add(:base, "Select atleast one student from the list below")
        end
      elsif !@registration.last_step?
        @registration.next_step
      end

      session[:step] = @registration.current_step
    end

    if !@registration.last_step?
      render "new"
    else
      puts "***************Transaction beginning**************"

      # Transaction to first save teaching records for each course and section
      # and save registration for each students
      begin
        ActiveRecord::Base.transaction do
          @sections.each do |section|
            session[:course_id_params].each do |course_id|
              if(Course.find_by(id: course_id)) 
                teaching = Teaching.find_or_create_by(section: section, course_id: course_id)
                @active_students.where(section: section).each do |student|
                  registration = @department.registrations.new(session[:registration_params])

                  # debugger

                  registration.student_id = student.id
                  registration.teaching_id = teaching.id
                
                  if registration.save!
                    puts "************Saving seems successful****************"
              

                  else
                    puts "************Saving seems NOOOOT successful****************"
                    flash.now[:alert] = 'Registration NOT successful!'
                    @registration.previous_step
                    session[:step] = @registration.current_step

                    render "new"
                    # throws error
                  end
                end
              else
                # Course not found
                # Throws error

              end
            end
          end
          session[:step] = session[:registration_params] = session[:course_id] = session[:student_id_params] = nil

          redirect_to department_registrations_path(@department), notice: "Registration was successful"
        end
      rescue => exception
        puts "************ error thrown captured **** Saving seems NOOOOT successful****************"

        flash.now[:alert] = 'Registration NOT successful!'

        @registration.previous_step
        session[:step] = @registration.current_step
        render "new"
      end
    end
  end

  # PATCH/PUT /registrations/1 or /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to registration_url(@registration), notice: "Registration was successfully updated." }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1 or /registrations/1.json
  def destroy
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url, notice: "Registration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_department
      @department = Department.find(params[:department_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def registration_params
      params.require(:registration).permit(:student_id, :grade, :academic_year, :class_year, :semester, :teaching_id)
    end

    def get_academic_years
      @academic_years = @department.registrations.pluck(:academic_year).uniq.sort
    end
end

class RegistrationsController < ApplicationController
  before_action :get_department
  before_action :set_registration, only: %i[ show edit update destroy ]

  # GET /registrations or /registrations.json
  def index
    session[:step] = session[:registration_params] = nil
    @registrations = @department.registrations
  end

  # GET /registrations/1 or /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    session[:registration_params] ||= {}

    @registration = @department.registrations.build
  end

  # GET /registrations/1/edit
  def edit
    session[:registration_params] ||= {}
  end

  # POST /registrations or /registrations.json
  def create
    session[:registration_params].deep_merge!(registration_params) if params[:registration]
    @registration = @department.registrations.build(session[:registration_params])

    @registration.current_step = session[:step]

    if @registration.valid?
      if params[:back_button]
        @registration.previous_step
      else
        @registration.next_step
      end

      session[:step] = @registration.current_step
    end

    if @registration.new_record?
      render "new"
    else
      session[:step] = session[:registration_params] = nil
      redirect_to department_registrations_path(@department), notice: "Registration was successful"
    end

    # respond_to do |format|
    #   if @registration.save
    #     format.html { redirect_to registration_url(@registration), notice: "Registration was successfully created." }
    #     format.json { render :show, status: :created, location: @registration }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @registration.errors, status: :unprocessable_entity }
    #   end
    # end
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
end

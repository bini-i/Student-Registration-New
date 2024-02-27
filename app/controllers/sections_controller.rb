class SectionsController < ApplicationController

  include FilterableController

  before_action :get_department
  before_action :get_class_years

  def index
    # console
    @students = filter(Student.all).where(status: "active")
    @sections = @department.students.where(class_year: params["class_year"]).pluck(:section).uniq.sort

    # @students = filtered_students || @department.students.order('first_name')
  end

  # Renders modal to change section of a student
  def change_section
    @student = Student.find(params[:student_id])
    @sections = @department.students.where(class_year: @student.class_year).pluck(:section).uniq.sort

    @sections.push(@sections.last.next)
    @sections.delete(@student.section)
  end

  def handle_section_change
    @student = Student.find(params[:student_id])

    @sections = @department.students.where(class_year: @student.class_year).pluck(:section).uniq.sort
    
    @sections.push(@sections.last.next)
    @sections.delete(@student.section)

    if @student.update(section: params[:section])
      # redirect_to request.referrer  #reload page
      redirect_to department_sections_index_path(class_year: @student.class_year, section: params[:section], student_id: params[:student_id])
    else
      render :change_section
    end
  end

  private
    def get_department
      @department = Department.find(params[:department_id])
    end

    def filter_params
      {
        admission_year: params[:admission_year],
        class_year: params[:class_year],
        section: params[:section],
      }
    end

    def filtered_students
      return unless params[:year].present?
      if params[:section]
        Student.section_students(@department, params[:year], params[:section])
      else
        Student.year_students(@department, params[:year])
      end
    end
    
    def get_class_years
      @class_years = @department.students.pluck(:class_year).uniq.sort
    end

    def get_sections
      @sections = Student.year_students(@department, params[:year]).pluck(:section).uniq.sort
    end
end

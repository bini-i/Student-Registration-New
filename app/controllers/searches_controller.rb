class SearchesController < ApplicationController
    before_action :get_department, except: %i[ index ] 
    before_action :get_admission_years, except: %i[ index ] 
    before_action :get_year_count, except: %i[ index ] 

    def index

    end

    def new
        @search = Search.new
    end

    def create
        @search = Search.create(search_params)
        redirect_to department_search_path(@department, @search)
    end

    def show
        @search = Search.find(params[:id])
    end

    private
        def search_params
            params.require(:search).permit(:first_name, :father_name, :student_id, :admission_year, :class_year, :status)
        end

        def get_department
            @department = Department.find(params[:department_id])
        end

        def get_year_count
            @year_count = @department.students.pluck(:class_year).uniq.size
        end

        def get_admission_years
            @admission_years = @department.students.pluck(:admission_year).uniq.sort
        end
end

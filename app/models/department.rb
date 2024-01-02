class Department < ApplicationRecord
    has_many :courses
    has_many :students
    
    validates :dept_name, uniqueness: true
end

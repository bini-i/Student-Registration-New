class Department < ApplicationRecord
    has_many :courses
    has_many :students
    has_many :registrations
    
    validates :dept_name, uniqueness: true
end

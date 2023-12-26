class Department < ApplicationRecord
    has_many :courses
    
    validates :dept_name, uniqueness: true
end

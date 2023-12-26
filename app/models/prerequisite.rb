class Prerequisite < ApplicationRecord
    belongs_to :course
    belongs_to :prerequisite_course, class_name: 'Course'
end

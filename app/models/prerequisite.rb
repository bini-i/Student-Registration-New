class Prerequisite < ApplicationRecord
    belongs_to :course, class_name: 'Course', foreign_key: :course_id
    belongs_to :prerequisite_course, class_name: 'Course', foreign_key: :prerequisite_course_id
end

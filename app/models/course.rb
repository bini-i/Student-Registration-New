class Course < ApplicationRecord
  belongs_to :prerequisite, optional: true, class_name: "Course"
  has_many :courses, foreign_key: "prerequisite_id", dependent: :nullify

  belongs_to :department
end

class Course < ApplicationRecord
  belongs_to :department
  has_many :teachings

  has_many :prerequisites, foreign_key: :course_id, class_name: 'Prerequisite', dependent: :destroy

  has_many :prerequisite_courses, through: :prerequisites, source: :prerequisite_course

  validates :course_name, presence: true, uniqueness: true, :if => lambda { |course| course.current_step == "course_info" } 
  validates :credit_hour, presence: true
  validates :ects, presence: true

  attr_writer :current_step

  def steps
    %w[course_info prerequisite confirmation]
  end

  def current_step
    @current_step || steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step? 
    current_step == steps.last
  end

  def prerequisite_step?
    current_step == steps.second
  end
end

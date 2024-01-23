class Registration < ApplicationRecord
  enum class_year: [:year_I, :year_II, :year_III, :year_IV, :year_V]
  enum semester: [:semester_I, :semester_II]

  belongs_to :student, optional: true
  belongs_to :teaching, optional: true
  belongs_to :department

  validates :class_year, presence: true
  validates :semester, presence: true

  attr_writer :current_step

  def steps
    %w[year courses students]
  end

  def current_step
    @current_step || steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step) - 1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

end

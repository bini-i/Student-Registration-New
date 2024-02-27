class Student < ApplicationRecord
  extend FilterableModel

  class << self
    def filter_proxy = Filters::StudentFilterProxy
  end

  enum status: [ :active, :withdrawn, :completed]
  enum class_year: [:year_I, :year_II, :year_III, :year_IV, :year_V]
  enum semester: [:semester_I, :semester_II]

  belongs_to :department
  has_many :registrations

  validates :first_name, presence: true
  validates :father_name, presence: true
  validates :last_name, presence: true

  validates :gender, presence: true

  validates :phone, presence: true
  validates :address, presence: true
  validates :nationality, presence: true

  validates :dob, presence: true
  validates :martial_status, presence: true

  validates :admission_type, presence: true
  
  validates :section, presence: true

  def full_name
    [first_name, father_name, last_name].join(' ')
  end

  scope :year_students, -> (department, year) { department.students.where(admission_year: year).order('first_name') }

  scope :class_year_students, -> (department, admission_year, class_year) { department.students.where(admission_year: admission_year, class_year: class_year).order('first_name') }

  scope :section_students, -> (department, year, section) { department.students.where(admission_year: year, section: section).order('first_name') }
  
  def search_result
    @students ||= find_students
  end

  private
    def find_students
        # TODO --- Search is looking in the whole student table --- consider looking through students of a given department
        students = Student.order(:first_name)
        students = students.where(admission_year: admission_year) if admission_year.present?
        students = students.where(class_year: class_year) if class_year.present?
        students = students.where(section: section) if section.present?
        students = students.where(status: status) if status.present?
        students
    end
end

class Student < ApplicationRecord
  belongs_to :department

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

  def full_name
    [first_name, father_name, last_name].join(' ')
  end

  scope :year_students, -> (department, year) { department.students.where(class_year: year).order('first_name') }
end

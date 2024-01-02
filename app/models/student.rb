class Student < ApplicationRecord
  validates :first_name, presence: true
  validates :father_name, presence: true
  validates :last_name, presence: true

  validates :gender, presence: true
  validates :martial_status, presence: true
  validates :dob, presence: true

  validates :nationality, presence: true
end

class Teaching < ApplicationRecord
  belongs_to :course
  belongs_to :user, optional: true
  has_many :registrations
end

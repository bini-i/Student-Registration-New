class Teaching < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :user
end

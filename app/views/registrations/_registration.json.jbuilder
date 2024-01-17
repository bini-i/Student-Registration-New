json.extract! registration, :id, :student_id, :grade, :academic_year, :class_uear, :semester, :teaching_id, :created_at, :updated_at
json.url registration_url(registration, format: :json)

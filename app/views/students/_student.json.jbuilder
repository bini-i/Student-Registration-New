json.extract! student, :id, :first_name, :father_name, :last_name, :gender, :martial_status, :nationality, :dob, :created_at, :updated_at
json.url student_url(student, format: :json)

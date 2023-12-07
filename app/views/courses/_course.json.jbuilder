json.extract! course, :id, :course_name, :credit_hour, :ects, :course_id, :department_id, :created_at, :updated_at
json.url course_url(course, format: :json)

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_01_22_114457) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.integer "credit_hour"
    t.integer "ects"
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "class_year"
    t.integer "semester"
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "dept_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prerequisites", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "prerequisite_course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_prerequisites_on_course_id"
    t.index ["prerequisite_course_id"], name: "index_prerequisites_on_prerequisite_course_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.decimal "grade"
    t.integer "academic_year"
    t.integer "class_year"
    t.integer "semester"
    t.bigint "teaching_id", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_registrations_on_department_id"
    t.index ["student_id"], name: "index_registrations_on_student_id"
    t.index ["teaching_id"], name: "index_registrations_on_teaching_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "student_id"
    t.string "first_name"
    t.string "father_name"
    t.integer "admission_year"
    t.integer "class_year"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "section_name"
    t.string "semester", null: false
    t.bigint "course_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
    t.index ["teacher_id"], name: "index_sections_on_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "father_name", null: false
    t.string "last_name", null: false
    t.string "gender", null: false
    t.string "phone", null: false
    t.hstore "address", null: false
    t.string "nationality", null: false
    t.date "dob", null: false
    t.string "martial_status", null: false
    t.integer "class_year", default: 1, null: false
    t.integer "semester", default: 1, null: false
    t.string "admission_type", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "section"
    t.integer "admission_year", null: false
    t.integer "status", null: false
    t.index ["department_id"], name: "index_students_on_department_id"
  end

  create_table "teachings", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "user_id"
    t.string "section"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_teachings_on_course_id"
    t.index ["user_id"], name: "index_teachings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.string "first_name"
    t.string "father_name"
    t.string "last_name"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "departments"
  add_foreign_key "prerequisites", "courses"
  add_foreign_key "prerequisites", "courses", column: "prerequisite_course_id"
  add_foreign_key "registrations", "departments"
  add_foreign_key "registrations", "students"
  add_foreign_key "registrations", "teachings"
  add_foreign_key "sections", "courses"
  add_foreign_key "sections", "users", column: "teacher_id"
  add_foreign_key "students", "departments"
  add_foreign_key "teachings", "courses"
  add_foreign_key "teachings", "users"
end

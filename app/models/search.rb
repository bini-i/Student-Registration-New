class Search < ApplicationRecord
    enum status: [ :active, :withdrawn, :completed]

    def students
        @students ||= find_students
    end

private

    def find_students
        # TODO --- Search is looking in the whole student table --- consider looking through students of a given department
        students = Student.order(:first_name)
        students = students.where("first_name like ?", "%#{first_name}%") if first_name.present?
        students = students.where("father_name like ?", "%#{father_name}%") if father_name.present?
        students = students.where(class_year: class_year) if class_year.present?
        students = students.where(admission_year: admission_year) if admission_year.present?
        students = students.where(status: status) if status.present?
        students
    end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Course.destroy_all

10.times do
    Course.create!(
        course_name: Faker::Book.title,
        credit_hour: Random.rand(3..5),
        ects: Random.rand(5..7),
        department_id: Random.rand(2..6),
    )
end

10.times do
    Course.create!(
        course_name: Faker::Book.title,
        credit_hour: Random.rand(3..5),
        ects: Random.rand(5..7),
        department_id: Random.rand(2..6),
        prerequisite_id: Course.all.pluck(:id).sample
    )
end

puts "20 courses created"
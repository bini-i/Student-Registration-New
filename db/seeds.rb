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
        course_name: Faker::Book.unique.title,
        credit_hour: Random.rand(3..5),
        ects: Random.rand(5..7),
        department_id: Random.rand(2..6),
    )
end

10.times do
    Course.create!(
        course_name: Faker::Book.unique.title,
        credit_hour: Random.rand(3..5),
        ects: Random.rand(5..7),
        department_id: Random.rand(2..6),
    )
end

puts "20 courses created"

Student.destroy_all

300.times do 
    Student.create!(
        first_name: Faker::Name.unique.first_name,
        father_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.first_name,
        admission_type: ["Regular", "Extension"].sample,
        gender: ["Male", "Female"].sample,
        phone: Faker::PhoneNumber.phone_number,
        dob: Faker::Date.between(from: '1990-09-23', to: '2005-09-25') ,
        nationality: "Ethiopia",
        martial_status: ["Single", "Married"].sample ,
        department_id: Random.rand(2..6),
        address: {
            woreda: "05",
            city: "",
            region: ""
        },
        class_year: Random.rand(1..5),
        semester: Random.rand(1..2)
    )
end

puts "300 courses created"
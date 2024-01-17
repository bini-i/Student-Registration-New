require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  setup do
    @registration = registrations(:one)
  end

  test "visiting the index" do
    visit registrations_url
    assert_selector "h1", text: "Registrations"
  end

  test "should create registration" do
    visit registrations_url
    click_on "New registration"

    fill_in "Academic year", with: @registration.academic_year
    fill_in "Class uear", with: @registration.class_uear
    fill_in "Grade", with: @registration.grade
    fill_in "Semester", with: @registration.semester
    fill_in "Student", with: @registration.student_id
    fill_in "Teaching", with: @registration.teaching_id
    click_on "Create Registration"

    assert_text "Registration was successfully created"
    click_on "Back"
  end

  test "should update Registration" do
    visit registration_url(@registration)
    click_on "Edit this registration", match: :first

    fill_in "Academic year", with: @registration.academic_year
    fill_in "Class uear", with: @registration.class_uear
    fill_in "Grade", with: @registration.grade
    fill_in "Semester", with: @registration.semester
    fill_in "Student", with: @registration.student_id
    fill_in "Teaching", with: @registration.teaching_id
    click_on "Update Registration"

    assert_text "Registration was successfully updated"
    click_on "Back"
  end

  test "should destroy Registration" do
    visit registration_url(@registration)
    click_on "Destroy this registration", match: :first

    assert_text "Registration was successfully destroyed"
  end
end

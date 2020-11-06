require 'rails_helper'

RSpec.describe 'Teachers course CRUD' do
  scenario "a teacher can see their dashboard (index action)" do
    stub_teacher_omniauth
    visit root_path
    choose(option: 'teachers')
    click_on "Sign in with Google"
    expect(current_path).to eq(teachers_courses_path)

    teacher = TeacherFacade.find(stub_teacher_omniauth[:uid])
    teacher_params = ({teacher_id: teacher.id})
    response = Faraday.get('http://localhost:3000/api/v1/teachers/courses') do |request|
      request.body = teacher_params
    end
    my_courses = JSON.parse(response.body, symbolize_names: true)
    course1_name = my_courses[:data][0][:attributes][:name]
    course2_name = my_courses[:data][0][:attributes][:name]

    teacher_params = ({teacher_id: 2})
    response = Faraday.get('http://localhost:3000/api/v1/teachers/courses') do |request|
      request.body = teacher_params
    end
    not_my_courses = JSON.parse(response.body, symbolize_names: true)
    course3_name = not_my_courses[:data][0][:attributes][:name]

    within '#my-courses' do
      expect(page).to have_content(course1_name)
      expect(page).to have_content(course2_name)
      expect(page).to_not have_content(course3_name)
    end
  end

  scenario "a teacher can create and destroy courses on their dashboard " do
    stub_teacher_omniauth
    visit root_path
    choose(option: 'teachers')
    click_on "Sign in with Google"
    expect(current_path).to eq(teachers_courses_path)

    teacher = TeacherFacade.find(stub_teacher_omniauth[:uid])
    teacher_params = ({teacher_id: teacher.id})

    teacher_course_params = {
      name: "Band 101",
      school_name: "Jim Bob's Happy House"
      }

    within '#my-courses' do
      expect(page).to_not have_content(teacher_course_params[:name])
    end

    # CREATE
    within '#add-courses' do
      fill_in :name, with: teacher_course_params[:name]
      fill_in :school_name, with: teacher_course_params[:school_name]
      click_on 'Add Course'
    end

    expect(current_path).to eq(teachers_courses_path)

    within '#my-courses' do
      expect(page).to have_content(teacher_course_params[:name])
    end

    teacher_params = ({teacher_id: 1})
    response = Faraday.get('http://localhost:3000/api/v1/teachers/courses') do |request|
      request.body = teacher_params
    end
    courses = JSON.parse(response.body, symbolize_names: true)
    course1_id = courses[:data].last[:id]

    # DESTROY
    within '#my-courses' do
      within "#course-#{course1_id}" do
        click_on 'Remove this Course'
      end
    end
    expect(current_path).to eq(teachers_courses_path)

    within '#my-courses' do
      expect(page).to_not have_content(teacher_course_params[:name])
    end
  end

  scenario 'a teacher can update names on courses' do
    stub_teacher_omniauth
    visit root_path
    choose(option: 'teachers')
    click_on "Sign in with Google"
    expect(current_path).to eq(teachers_courses_path)

    teacher = TeacherFacade.find(stub_teacher_omniauth[:uid])
    teacher_params = ({teacher_id: teacher.id})
    response = Faraday.get('http://localhost:3000/api/v1/teachers/courses') do |request|
      request.body = teacher_params
    end
    courses = JSON.parse(response.body, symbolize_names: true)
    course1_id = courses[:data][0][:id]
    course1_name = courses[:data][0][:attributes][:name]
    course1_school_name = courses[:data][0][:attributes][:school_name]
    course2_name = courses[:data][1][:attributes][:name]
    course2_school_name = courses[:data][1][:attributes][:school_name]

    within '#my-courses' do
      expect(page).to have_content(course1_name)
      expect(page).to have_content(course1_school_name)
      expect(page).to have_content(course2_name)
      expect(page).to have_content(course2_school_name)
    end

    within '#my-courses' do
      within "#course-#{course1_id}" do
        click_on 'Update this Course'
      end
    end
    expect(current_path).to eq("/teachers/courses/#{course1_id}/edit")

    update_params = {
      name: "This Course has been updated",
      school_name: "This School Name has been updated"
    }
    fill_in :name, with: update_params[:name]
    fill_in :school_name, with: update_params[:school_name]
    click_on 'Update Course'
    expect(current_path).to eq(teachers_courses_path)

    within '#my-courses' do
      expect(page).to_not have_content(course1_name)
      expect(page).to_not have_content(course1_school_name)
      expect(page).to have_content(course2_name)
      expect(page).to have_content(course2_school_name)
      expect(page).to have_content(update_params[:name])
      expect(page).to have_content(update_params[:school_name])
    end

    # RETURN THE LIVE DATABASE BACK TO ORIGINAL
    within '#my-courses' do
      within "#course-#{course1_id}" do
        click_on 'Update this Course'
      end
    end

    update_params = {
      name: course1_name,
      school_name: course1_school_name
    }
    fill_in :name, with: update_params[:name]
    fill_in :school_name, with: update_params[:school_name]
    click_on 'Update Course'
  end

  scenario 'a teacher can view a single courses show page' do
    stub_teacher_omniauth
    visit root_path
    choose(option: 'teachers')
    click_on "Sign in with Google"
    expect(current_path).to eq(teachers_courses_path)

    teacher = TeacherFacade.find(stub_teacher_omniauth[:uid])
    teacher_params = ({teacher_id: teacher.id})
    response = Faraday.get('http://localhost:3000/api/v1/teachers/courses') do |request|
      request.body = teacher_params
    end

    course = JSON.parse(response.body, symbolize_names: true)
    course_id = course[:data][0][:id]
    course_name = course[:data][0][:attributes][:name]
    course2_name = course[:data][1][:attributes][:name]

    within '#my-courses' do
      within "#course-#{course_id}" do
        click_on "#{course_name}"
      end
    end
    expect(current_path).to eq("/teachers/courses/#{course_id}")
    expect(page).to have_content(course_name)
    expect(page).to_not have_content(course2_name)
  end

  scenario 'a teacher can see their students on a course show page' do
    stub_teacher_omniauth
    visit root_path
    choose(option: 'teachers')
    click_on "Sign in with Google"
    expect(current_path).to eq(teachers_courses_path)

    teacher = TeacherFacade.find(stub_teacher_omniauth[:uid])
    teacher_params = ({teacher_id: teacher.id})
    response = Faraday.get('http://localhost:3000/api/v1/teachers/courses') do |request|
      request.body = teacher_params
    end

    my_courses = JSON.parse(response.body, symbolize_names: true)[:data]
    course1_id = my_courses[0][:id].to_i
    course1_name = my_courses[0][:attributes][:name]
    course_params = ({course_id: course1_id})
    response = Faraday.get('http://localhost:3000/api/v1/teachers/courses/students') do |request|
      request.body = course_params
    end
    my_students = JSON.parse(response.body, symbolize_names: true)[:data]
    within '#my-courses' do
      within "#course-#{course1_id}" do
        click_on "#{course1_name}"
      end
    end
    my_students.each do |student|
      within "#student-#{student[:id].to_i}" do
        expect(page).to have_content(student[:attributes][:first_name])
        expect(page).to have_content(student[:attributes][:last_name])
      end
    end
  end
end

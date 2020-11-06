# require 'rails_helper'
#
# RSpec.describe 'Teachers Course Show' do
#   it 'can click a button to generate a POM' do
#     stub_teacher_omniauth
#     visit root_path
#     choose(option: 'teachers')
#     click_on "Sign in with Google"
#     visit teachers_courses_path
#
#     click_button('Generate POM')
#     response = Faraday.new('http://localhost:3000/api/v1/pom/single_trivia_question').get
#     pom = JSON.parse(response.body, symbolize_names: true)
#
#     expect(pom).to be_a(Hash)
#     expect(pom).to have_key(:response_code)
#     expect(pom[:response_code]).to eq(0)
#
#     expect(pom).to have_key(:results)
#     expect(pom[:results]).to be_an(Array)
#
#     expect(pom[:results][0]).to be_a(Hash)
#     expect(pom[:results][0][:category]).to be_a(String)
#     expect(pom[:results][0][:type]).to be_a(String)
#     expect(pom[:results][0][:difficulty]).to be_a(String)
#     expect(pom[:results][0][:question]).to be_a(String)
#     expect(pom[:results][0][:correct_answer]).to be_a(String)
#     expect(pom[:results][0][:incorrect_answers]).to be_an(Array)
#   end
#
#   it 'can display a POM after clicking the button' do
#     stub_teacher_omniauth
#     visit root_path
#     choose(option: 'teachers')
#     click_on "Sign in with Google"
#     visit teachers_courses_path
#
#     click_button('Generate POM')
#
#     within('.poms') do
#       expect(page).to have_content('Question: ')
#       expect(page).to have_content('Answer: ')
#     end
#   end
# end

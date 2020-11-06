class Student
attr_reader :id,
            :provider,
            :uid,
            :email,
            :token,
            :first_name,
            :last_name,
            :role,
            :courses,
            :points,
            :poms

  def initialize(student_info, course_student_data = nil, course_data = nil, pom_data = nil)
    @id = student_info[:id].to_i
    @provider = student_info[:attributes][:provider]
    @uid = student_info[:attributes][:uid]
    @email = student_info[:attributes][:email]
    @token = student_info[:attributes][:token]
    @first_name = student_info[:attributes][:first_name]
    @last_name = student_info[:attributes][:last_name]
    @points = course_student_data[:attributes][:points].to_i if course_student_data
    @role = student_info[:attributes][:role]

    @courses = course_data.map { |course| Course.new(course) } if course_data
    @poms = pom_data.map { |pom| Pom.new(pom) } if pom_data
  end
end

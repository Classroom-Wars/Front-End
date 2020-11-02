class Teacher
  attr_reader :id,
              :provider,
              :uid,
              :email,
              :token,
              :first_name,
              :last_name,
              :school_name,
              :school_district

  def initialize(teacher_info)
    @id = teacher_info[:data][:id]
    @provider = teacher_info[:data][:attributes][:provider]
    @uid = teacher_info[:data][:attributes][:uid]
    @email = teacher_info[:data][:attributes][:email]
    @token = teacher_info[:data][:attributes][:token]
    @first_name = teacher_info[:data][:attributes][:first_name]
    @last_name = teacher_info[:data][:attributes][:last_name]
    @school_name = teacher_info[:data][:attributes][:school_name]
    @school_district = teacher_info[:data][:attributes][:school_district]
  end
end

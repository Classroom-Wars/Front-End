class TeachersService
  def self.conn(uri)
    url = ENV['CLASS_WARS_DOMAIN'] + uri
    Faraday.new(url)
  end

  def self.create_war(creation_params, teacher_id)
    creation_params[:teacher_id] = teacher_id.to_i
    response = conn("/api/v1/teachers/courses/wars").post do |request|
      request.body = creation_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_all_wars(teacher)
    teacher_wars_params = {teacher_id: teacher[:data][:id].to_i}
    response = conn("/api/v1/teachers/courses/wars").get do |request|
      request.body = teacher_wars_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_teacher(id)
    response = conn("/api/v1/teachers/#{id}").get
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_single_course(id)
    response = conn("/api/v1/teachers/courses/#{id}").get
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_all_courses(teacher)
    teacher_course_params = {teacher_id: teacher[:data][:id].to_i}
    response = conn("/api/v1/teachers/courses").get do |request|
      request.body = teacher_course_params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.course_by_code(code)
    response = conn("/api/v1/teachers/courses/find?coursecode=#{code}").get
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.create_course(data, id)
    response = conn("/api/v1/teachers/courses/#{id}").post do |request|
      request.body = data
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.edit_course(id)
    response = conn("/api/v1/teachers/courses/#{id}").get
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.update_course(id, data)
    response = conn("/api/v1/teachers/courses/#{id}").patch do |request|
      request.body = data
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.destroy_course(id)
    conn("/api/v1/teachers/courses/#{id}").delete
  end

  def self.destroy_war(id)
    conn("/api/v1/teachers/courses/wars/#{id}").delete
  end

  def self.get_all_prizes(teacher)
    teacher_course_params = {teacher_id: teacher[:data][:id].to_i}
    response = conn("/api/v1/teachers/courses/all-prizes").get do |request|
      request.body = teacher_course_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_students_by_course(id)
    course_params = {course_id: id}
    response = conn("/api/v1/teachers/courses/students").get do |request|
      request.body = course_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end
end

class TeachersFacade
  def self.get_all_courses(id)
    teacher = TeachersService.get_teacher(id)
    json = TeachersService.get_all_courses(teacher)
    @courses = json[:data].map do |course_data|
      Course.new(course_data)
    end
  end

  def self.post_new_course(data, id, teacher_id)
    teacher = get_teacher(teacher_id)
    teacher_course_creation_params = {
      name: data[:name],
      teacher_id: teacher[:data][:id].to_i,
      school_name: data[:school_name]
    }
    TeachersService.create_course(teacher_course_creation_params, id)
  end

  def self.post_new_war(data, challenger_course_id, teacher_id)
    teacher = get_teacher(teacher_id)
    challenger_course = get_course(challenger_course_id)
    opponent_course = find_course_by_code(data[:opponent_course_code])
    war_params = {
      challenger_course_id: challenger_course.id.to_i,
      opponent_course_id: opponent_course.id.to_i,
      challenger_course_points: challenger_course.course_points,
      opponent_course_points: opponent_course.course_points,
      opponent_course_name: opponent_course.name
    }
    war_data = TeachersService.create_war(war_params, teacher[:data][:id])
    War.new(war_data)
  end

  def self.get_all_wars(id)
    teacher = TeachersService.get_teacher(id)
    json = TeachersService.get_all_wars(teacher)
    @wars = json.map do |war_data|
      War.new(war_data)
    end
  end

  def self.destroy_war(id)
    TeachersService.destroy_war(id)
  end

  def self.get_teacher(id)
    TeachersService.get_teacher(id)
  end

  def self.get_course(id)
    course_data = TeachersService.get_single_course(id)
    Course.new(course_data)
  end

  def self.edit_course(id)
    course_data = TeachersService.edit_course(id)
    Course.new(course_data)
  end

  def self.update_course(id, data)
    course_data = TeachersService.update_course(id, data)
    Course.new(course_data)
  end

  def self.destroy_course(id)
    TeachersService.destroy_course(id)
  end

  def self.find_course_by_code(code)
    course_data = TeachersService.course_by_code(code)
    Course.new(course_data)
  end

  def self.get_all_prizes(id)
    teacher = TeachersService.get_teacher(id)
    json = TeachersService.get_all_prizes(teacher)
    @prizes = json.map do |prize_data|
      Prize.new(prize_data)
    end
  end

  def self.students_in_course(id)
    json = TeachersService.get_students_by_course(id)
    @students = json.map do |student_data|
      Student.new(student_data)
    end
  end
end

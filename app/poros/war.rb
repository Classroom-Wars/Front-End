class War
  attr_reader :id,
              :challenger_course_id,
              :opponent_course_id,
              :challenger_course_points,
              :opponent_course_points,
              :opponent_course_name

  def initialize(attrs)
    @id = attrs[:id].to_i
    @challenger_course_id = attrs[:attributes][:challenger_course_id]
    @opponent_course_id = attrs[:attributes][:opponent_course_id]
    @challenger_course_points = attrs[:attributes][:challenger_course_points].to_i
    @opponent_course_points = attrs[:attributes][:opponent_course_points].to_i
    @opponent_course_name = attrs[:attributes][:opponent_course_name]
  end
end

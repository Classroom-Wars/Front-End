class StudentFacade
  def self.find(uid)
    response = Faraday.get("http://localhost:3000/api/v1/students/find/#{uid}")
    parsed_data = JSON.parse(response.body, symbolize_names: true)[:data]
    Student.new(parsed_data)
  end
end

class Pom
  attr_reader :name,
  :description,
  :duration,
  :link,
  :id

  def initialize(pom_data)
    @name = pom_data[:attributes][:name]
    @description = pom_data[:attributes][:description]
    @duration = pom_data[:attributes][:duration]
    @link = pom_data[:attributes][:link]
    @id = pom_data[:attributes][:id].to_i
  end
end

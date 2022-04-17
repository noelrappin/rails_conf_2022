class Search
  attr_accessor :project

  def initialize(project)
    @project = project
  end

  def search(query)
    project.cards.where("description LIKE '%s'", "%#{query}%")
      .or(project.cards.where("name LIKE '%s'", "%#{query}%"))
      .or(project.cards.where("slug LIKE '%s'", "%#{query}%"))
  end
end

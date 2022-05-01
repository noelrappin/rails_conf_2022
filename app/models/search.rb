class Search
  attr_accessor :project

  def initialize(project)
    @project = project
  end

  def search(query)
    query = query.strip
    result = project.cards.where("description LIKE '%s'", "%#{query}%")
      .or(project.cards.where("name LIKE '%s'", "%#{query}%"))
      .or(project.cards.where("slug LIKE '%s'", "%#{query}%"))
    project.search_complete(query) if result.length > 0
    result
  end
end

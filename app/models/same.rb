class Same

  def self.check(name)
    check = Query.find_by name: name
    if check.nil?
      films = Swapi.get_films(name)
    else
      films = check.film
    end
    films.split(", ")
  end

  def self.compare(name1, name2)
    check(name1) & check(name2)
  end

end
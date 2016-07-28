class Same

  def self.check(name)
    search = name.split(" ").map{|word| word.capitalize}.join(" ")
    check = Query.find_by name: search
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
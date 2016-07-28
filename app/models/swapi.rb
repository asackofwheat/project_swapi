class Swapi

  FUN_FACT = ["height", "mass", "hair_color", "skin_color", "eye_color", "birth_year", "gender"]

  MOVIE_TITLES = {"http://swapi.co/api/films/1/" => "EP4: A New Hope",
                  "http://swapi.co/api/films/2/" => "EP5: The Empire Strikes Back",
                  "http://swapi.co/api/films/3/" => "EP6: Return of the Jedi",
                  "http://swapi.co/api/films/4/" => "EP1: The Phantom Menace",
                  "http://swapi.co/api/films/5/" => "EP2: Attack of the Clones",
                  "http://swapi.co/api/films/6/" => "EP3: Revenge of the Sith",
                  "http://swapi.co/api/films/7/" => "EP7: The Force Awakens"}

  def self.get_films(name)
    result = find_stat(name, "films")
    return nil if result.nil?
    result.map{|url| MOVIE_TITLES[url]}.sort.join(", ")
  end

  def self.find_stat(name, stat)
    result = nil
    page_num = 1
    until result || page_num == 10
      return_hash = HTTParty.get("http://swapi.co/api/people/?page=#{page_num}")
      return_hash["results"].each do |person|
        result = person[stat] if person["name"].downcase.include?(name.downcase)
      end
      page_num += 1
    end
    result
  end

  def self.fun_fact(name)
    stat = FUN_FACT.sample
    result = find_stat(name, stat)
    "Did you know that #{name}'s #{stat.gsub("_", " ")} is #{result}?"
  end

end
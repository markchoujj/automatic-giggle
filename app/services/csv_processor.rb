class CsvProcessor
  def initialize(file)
    @file = file
  end

  def process!
    headers = @file[0]
    #find out indexes of each header
    indexes = header_indexes(headers)
    individuals = @file[1..]
    individuals.each do |individual|
      affiliation_names = individual[indexes[4]]
      #skip if a person has no affiliation
      unless affiliation_names.nil?
        affiliations, locations = [], []
        affiliation_names = affiliation_names.split(",")
        #get affiliations
        affiliation_names.each do |affiliation_name|
          affiliation = Affiliation.find_or_create_by(name: affiliation_name)
          affiliations.push(affiliation)
        end
        #get locations
        location_names = individual[indexes[1]].split(",").map{|location| location.strip.capitalize}
        location_names.each do |location_name|
          location = Location.find_or_create_by(name: location_name)
          locations.push(location)
        end
        #get first and last names
        name = individual[indexes[0]].split(' ')
        first_name = name.first.capitalize
        last_name = name.last.capitalize unless name.length == 1
        #get species and vehicles
        species, vehicle = individual[indexes[2]], individual[indexes[-1]]
        #get gender
        gender = individual[indexes[3]]
        gender = formalize_gender(gender)
        #get weapon
        weapon = individual[indexes[5]]
        weapon = weapon.gsub!(/\W+/, '') if weapon.present?
        #create person
        person = Person.create!(
          first_name: first_name,
          last_name: last_name,
          species: species,
          gender: gender,
          weapon: weapon,
          vehicle: vehicle
        )
        #create location person associations
        locations.each do |location|
          PersonLocation.create(person_id: person.id, location_id: location.id)
        end
        #create affiliation person associations
        affiliations.each do |affiliation|
          PersonAffiliation.create(person_id: person.id, affiliation_id: affiliation.id)
        end
      end
    end
  end

  private
  def header_indexes(headers)
    [
     headers.find_index("Name"),              #0
     headers.find_index("Location"),          #1
     headers.find_index("Species"),           #2
     headers.find_index("Gender"),            #3
     headers.find_index("Affiliations"),      #4
     headers.find_index("Weapon"),            #5
     headers.find_index("Vehicle")            #6
   ]
  end

  def formalize_gender(gender)
    case gender.first.downcase
    when "o"
      "Other"
    when "f"
      "Female"
    when "m"
      "Male"
    end
  end
end
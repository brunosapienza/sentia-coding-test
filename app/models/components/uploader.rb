module Components
  class Uploader
    require 'csv'

    attr_reader :people

    def initialize(file)
      @file = file
      @people = []
    end

    def parse
      CSV.foreach(@file.path, headers: true) do |row|
        next if row["Affiliations"].nil?
        @people << build_person(row.to_h)
      end

      @people
    end

    def import!
      ActiveRecord::Base.transaction do
        @people.each do |person|
          person.locations = person.locations.map do |location|
            Location.find_or_initialize_by(name: location.name)
          end

          person.affiliations = person.affiliations.map do |affiliation|
            Affiliation.find_or_initialize_by(name: affiliation.name)
          end

          person.save
        end
      end
    end

    private

    def build_person(row)
      name = row["Name"].split(" ", 2).map(&:downcase).map(&:titlecase)
      gender = normalise_gender(row["Gender"])

      person = Person.new(
        first_name: sanitise(name[0]),
        last_name: sanitise(name[1]),
        gender: gender,
        species: sanitise(row["Species"]),
        weapon: sanitise(row["Weapon"]),
        vehicle: sanitise(row["Vehicle"]),
      )

      cleanup_list(build_list(row["Location"])).each do |location|
        person.locations << Location.new(name: location)
      end

      cleanup_list(build_list(row["Affiliations"])).each do |affiliation|
        person.affiliations << Affiliation.new(name: affiliation)
      end

      person
    end

    def normalise_gender(gender)
      gender_dictionary = {
        "male" => "Male",
        "m" => "Male",
        "female" => "Female",
        "f" => "Female",
      }

      gender_dictionary[sanitise(gender.downcase)] || gender
    end

    def build_affiliations(person, row)
      person.affiliations.build(
        cleanup_list(build_list(row["Affiliations"]))
          .map { |location| { name: location } }
      )
    end

    def build_list(data)
      return if data.nil?
      data.split(",").map(&:strip)
    end

    def cleanup_list(list)
      return if list.nil?

      list
        .flatten
        .compact
        .map(&:downcase)
        .uniq
        .map(&:titlecase)
        .map { |entry| sanitise(entry) }
    end

    def sanitise(string)
      string.try(:tr, "^A-Za-z0-9", " ").try(:rstrip)
    end
  end
end

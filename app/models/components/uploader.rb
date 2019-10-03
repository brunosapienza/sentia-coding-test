module Components
  class Uploader
    require 'csv'

    def initialize(file)
      @file = file
      @people = []
      @locations = []
      @affiliations = []
    end

    def parse
      affiliations = []
      locations = []

      CSV.foreach(@file.path, headers: true) do |row|
        data = row.to_h

        @people << build_person(data)
        affiliations << build_list(data["Affiliations"])
        locations << build_list(data["Location"])
      end

      cleanup_list(affiliations).each do |affiliation|
        @affiliations << Affiliation.new(name: affiliation)
      end

      cleanup_list(locations).each do |location|
        @locations << Location.new(name: location)
      end

      byebug
    end

    def import!
      #ActiveRecord::Base.transaction do
        imported_locations = Location.import(@locations)
        imported_affiliations = Affiliation.import(@affiliations)
        byebug
      #end
    end

    private

    def build_person(data)
      name = data["Name"].split(" ", 2)
      species = data["Species"]
      gender = data["Gender"]
      weapon = data["Weapon"]
      vehicle = data["Vehicle"]

      {
        first_name: name[0], last_name: name[1], gender: gender,
        species: species, weapon: weapon, vehicle: vehicle,
        locations: cleanup_list(build_list(data["Location"])),
        affiliations: cleanup_list(build_list(data["Affiliations"]))
      }
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
    end
  end
end

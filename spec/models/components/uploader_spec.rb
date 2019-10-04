require 'rails_helper'

RSpec.describe Components::Uploader do
  let(:file) { File.join(Rails.root, 'spec', 'fixtures', 'test.csv') }
  let(:uploader) { described_class.new(File.new(file)) }

  describe "#parse" do
    let(:parsed_result) { uploader.parse }

    it "parses name into first_name and last_name" do
      expect(parsed_result[0].first_name).to eq("Darth")
      expect(parsed_result[0].last_name).to eq("Vadar")
    end

    it "title cases first_name and last_name" do
      expect(parsed_result[8].first_name).to eq("Luke")
      expect(parsed_result[8].last_name).to eq("Skywalker")
    end

    it "parses a compost last_name" do
      expect(parsed_result[5].first_name).to eq("Jabba")
      expect(parsed_result[5].last_name).to eq("The Hutt")
    end

    it "normalises the gender" do
      expect(parsed_result[1].gender).to eq("Male")
      expect(parsed_result[13].gender).to eq("Female")
    end

    it "ignores a person without an affiliation" do
      expect(parsed_result.select { |p| p.first_name == "Boba" }).to eq([])
    end
  end

  describe "#import!" do
    it "persists the data into the db" do
      uploader.parse
      expect { uploader.import! }.to change { Person.count }.from(0).to(17)
    end

    it "creates the proper relationships" do
      uploader.parse
      uploader.import!

      rebel_alliance = Affiliation.find_by(name: "Rebel Alliance")
      expect(rebel_alliance.people.size).to eq(6)
      expect(rebel_alliance.people.map(&:first_name)).to eq(["Chewbacca", "Princess", "Luke", "R2 D2", "Han", "Lando"])

      naboo = Location.find_by(name: "Naboo")
      expect(naboo.people.map(&:first_name)).to eq(["Sheev", "Jar", "R2 D2", "Padme"])

      darth_vader = Person.find_by(first_name: "Darth")
      expect(darth_vader.locations.map(&:name)).to eq(["Death Star", "Tatooine"])

      princess_leia = Person.find_by(first_name: "Princess")
      expect(princess_leia.affiliations.map(&:name)).to eq(["Rebel Alliance", "Galactic Republic"])
    end
  end
end

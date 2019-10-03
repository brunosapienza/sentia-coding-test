class Affiliation < ApplicationRecord
  has_many :affiliations_people, class_name: 'AffiliationsPeople'
  has_many :people, through: :affiliations_people

  validates :name, presence: true
  validates_uniqueness_of :name
end

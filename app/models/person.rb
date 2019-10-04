class Person < ApplicationRecord
  has_many :locations_people, class_name: 'LocationsPeople'
  has_many :affiliations_people, class_name: 'AffiliationsPeople'

  has_many :locations, through: :locations_people
  has_many :affiliations, through: :affiliations_people

  validates :first_name, presence: true
  validates :gender, presence: true
  validates :species, presence: true
  validates_uniqueness_of :first_name

  #paginates_per 10
end

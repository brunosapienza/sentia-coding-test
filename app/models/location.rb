class Location < ApplicationRecord
  has_many :locations_people, class_name: 'LocationsPeople'
  has_many :people, through: :locations_people

  validates :name, presence: true
  validates_uniqueness_of :name
end

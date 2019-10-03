class LocationsPeople < ApplicationRecord
  belongs_to :person
  belongs_to :location
end

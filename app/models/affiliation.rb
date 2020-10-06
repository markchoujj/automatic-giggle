class Affiliation < ApplicationRecord
  has_many :person_affiliations
  has_many :people, through: :person_affiliations
end

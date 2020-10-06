class Person < ApplicationRecord
  paginates_per 10
  has_many :person_affiliations
  has_many :person_locations
  has_many :affiliations, through: :person_affiliations
  has_many :locations, through: :person_locations

  validates :first_name, :species, :gender, presence: true
  validate :name_uppercase

  private
  def name_uppercase
    errors.add(:first_name, "Must be capitalized") unless self.first_name.capitalize == self.first_name
    errors.add(:last_name, "Must be capitalized") unless
    (self.last_name.nil? || self.last_name.capitalize == self.last_name)
  end
end

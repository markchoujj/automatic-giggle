class CreatePersonLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :person_locations do |t|
      t.references :person, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end

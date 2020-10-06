class CreatePersonAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_table :person_affiliations do |t|
      t.references :person, foreign_key: true
      t.references :affiliation, foreign_key: true

      t.timestamps
    end
  end
end
